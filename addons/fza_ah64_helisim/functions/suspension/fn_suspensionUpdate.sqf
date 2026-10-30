/* ----------------------------------------------------------------------------
Function: fza_ah64_helisim_fnc_suspensionUpdate

Description:
    Carries the aircraft on its three landing gear struts and applies the tyre
    forces. The hull only meets the ground once a strut runs out of travel.

    addForce takes an impulse once a frame, so each force is solved implicitly
    over the whole frame to stay stable at low frame rates.

Parameters:
    _heli - The helicopter [Object]

Returns:
    Nothing
---------------------------------------------------------------------------- */
#include "\bmkhs_helisim\functions\core\core.hpp"

//Longest step a strut stays stable over. Past it the hull takes the weight.
#define MAX_STEP 0.18
//Time acceleration gets here. One lump of force over a step this long can't follow the spring,
//so the strut carries its load and takes out some of the motion from the last step.
#define LONG_STEP 0.1
#define LONG_STEP_CANCEL 0.4
#define LONG_STEP_CANCEL_TAIL 0.16
#define LONG_STEP_LOAD 1.25
#define CARRIED_LOAD_LIMIT 1.25
#define MAX_HEIGHT 5
//Starts above the contact point, so a strut past its travel still finds the ground
#define RAY_LEAD 1.0

params ["_heli"];

//Here, not at setup: a machine that takes the aircraft over later never ran it
if (isNil {_heli getVariable "fza_ah64_suspWheels"}) then {
    [_heli] call fza_ah64_helisim_fnc_suspensionVariables;
};

if (isGamePaused) exitWith {};

private _dt      = diag_deltaTime * accTime;
private _frame   = diag_frameNo;
private _skipped = _frame != ((_heli getVariable "fza_ah64_suspFrame") + 1);
_heli setVariable ["fza_ah64_suspFrame", _frame];

private _wheels  = _heli getVariable "fza_ah64_suspWheels";
private _prevArm = _heli getVariable "fza_ah64_suspPrevArm";
private _anchors = _heli getVariable "fza_ah64_suspAnchors";
private _struts  = _heli getVariable "fza_ah64_suspStruts";

if (_skipped) then {
    {_prevArm set [_forEachIndex, []]} forEach _wheels;
};

if (_dt > MAX_STEP
    || {(getPos _heli select 2) > MAX_HEIGHT}
    || {!simulationEnabled _heli}
    || {!isNull attachedTo _heli}
    || {!isNull isVehicleCargo _heli}) exitWith {
    if (fza_ah64_suspensionDebug > 0 && {_dt > MAX_STEP}) then {
        diag_log format ["FZASUSP_SKIP,%1,%2,%3", CBA_missionTime toFixed 3, _dt toFixed 4, accTime];
    };
    {
        _prevArm set [_forEachIndex, []];
        _anchors set [_forEachIndex, []];
        _struts  set [_forEachIndex, []];
    } forEach _wheels;
};

(_heli getVariable "fza_ah64_suspTuning") params [
    "_gasExponent", "_dampingLimit", "_sealFriction", "_sealTravel", "_loadFilter",
    "_crossTube", "_tyreStiffness",
    "_rollingFriction", "_brakeFriction", "_sideFriction", "_slideRatio",
    "_casualSideFriction", "_casualSlideRatio",
    "_casterFriction"
];

private _up = vectorUp _heli;

private _contacts = _wheels apply {
    _x params ["_pos", "_extension"];
    private _contact = _heli modelToWorldWorld _pos;
    private _full    = _contact vectorDiff (_up vectorMultiply _extension);
    private _hits    = lineIntersectsSurfaces [_contact vectorAdd (_up vectorMultiply RAY_LEAD), _full, _heli, objNull, true, 3, "GEOM", "NONE"];
    private _ground  = _hits findIf {!((_x select 3) isKindOf "CAManBase")};
    if (_ground < 0) then {
        [_contact, 0, []]
    } else {
        (_hits select _ground) params ["_hitPos", "_normal"];
        [_contact, (_hitPos vectorDiff _full) vectorDotProduct _up, [_up, _normal] select ((_normal select 2) > 0.5)]
    };
};

private _tube = _crossTube * (((_contacts select 0 select 1) max 0) - ((_contacts select 1 select 1) max 0));

private _mass     = getMass _heli;
private _fwd      = vectorDir _heli;
private _brakeSet = _heli getVariable ["fza_ah64_parkingBrake", true];
//Casual's centre of mass sits high for handling, and tyre forces would roll it over from there
private _casual   = bmkhs_helisimRealismSetting != REALISTIC;
if (_casual) then {
    _sideFriction = _casualSideFriction;
    _slideRatio   = _casualSlideRatio;
};
private _com      = getCenterOfMass _heli;
private _velocity = velocity _heli;
private _debug    = fza_ah64_suspensionDebug > 0;
private _log      = [];

{
    _x params ["_pos", "_extension", "_travel", "_gasLength", "_share", "_hasBrake", "_staticLoad", "_damper", "_preload"];
    (_contacts select _forEachIndex) params ["_contact", "_compression", "_normal"];

    //Differencing the arm gives the rotation with no sign to get wrong, and it is small
    //enough to keep its precision where a world position would not
    private _arm  = _heli vectorModelToWorld (_pos vectorDiff _com);
    private _prev = _prevArm select _forEachIndex;
    private _spin = if (_prev isEqualTo []) then {[0, 0, 0]} else {(_arm vectorDiff _prev) vectorMultiply (1 / _dt)};
    private _vel  = _velocity vectorAdd _spin;
    _prevArm set [_forEachIndex, _arm];

    if (_normal isEqualTo [] || {_compression <= 0}) then {
        _anchors set [_forEachIndex, []];
        _struts  set [_forEachIndex, []];
        if (_debug) then {_log pushBack [_compression, 0, 0, 0, 0, 0, 0, 0, 0, _contact select 2]};
        continue;
    };

    //Strut
    (_struts select _forEachIndex) params [["_prevCompression", _compression], ["_sealAt", _compression], ["_carried", -1]];
    private _strutRate = (_compression - _prevCompression) / _dt;

    private _gasRoom = _gasLength + _extension - (_compression min _travel);
    private _gas     = (_gasLength / _gasRoom) ^ _gasExponent;
    private _spring  = _staticLoad * (_gas - _preload) / (1 - _preload);
    private _rate    = _gasExponent * _staticLoad * _gas / (_gasRoom * (1 - _preload));
    if (_forEachIndex < 2) then {
        _spring = (_spring + ([-_tube, _tube] select (_forEachIndex == 0))) max 0;
        _rate   = _rate + (2 * _crossTube);
    };

    //The seals hold the strut rigid until the force on them reaches breakout, then slide
    private _breakout = _sealFriction * _staticLoad;
    private _sealRate = _breakout / _sealTravel;
    private _seal     = _sealRate * (_compression - _sealAt);
    if (abs _seal > _breakout) then {
        _seal   = _breakout * ([-1, 1] select (_seal > 0));
        _sealAt = _compression - (_seal / _sealRate);
    } else {
        _rate = _rate + _sealRate;
    };
    _spring = (_spring + _seal) max 0;

    _carried = if (_carried < 0) then {_spring} else {_carried + ((_spring - _carried) * ((_dt / _loadFilter) min 1))};
    _carried = _carried min (CARRIED_LOAD_LIMIT * _spring);
    private _longStep = _dt > LONG_STEP;
    if (_longStep) then {_carried = _carried min (LONG_STEP_LOAD * _staticLoad)};
    _struts set [_forEachIndex, [_compression, _sealAt, _carried]];

    //The load it carries goes on whole, and only what differs from that is solved implicitly.
    //Strut rate has no bias at rest, so the weight stays carried at any step length.
    private _sprung  = _mass * _share;
    private _damping = (_damper * _dt) + (_rate * _dt * _dt);
    private _softer  = 1 + (_damping / _sprung);
    private _maxDamp = _dampingLimit * _staticLoad * _dt;
    private _load    = 0;
    if (_longStep) then {
        private _cancel = [LONG_STEP_CANCEL_TAIL, LONG_STEP_CANCEL] select _hasBrake;
        _load = (_carried * _dt) + ((_spring - _carried) * _dt / _softer) + (_cancel * _sprung * (_strutRate min (_maxDamp / (_damping max 1))));
        _load = (_load min (LONG_STEP_LOAD * _staticLoad * _dt)) max 0;
    } else {
        _load = ((_carried * _dt) + ((((_spring - _carried) * _dt) + ((_damping * _strutRate) min _maxDamp)) / _softer)) max 0;
    };
    private _forceAt = [_pos, [_pos select 0, _pos select 1, _com select 2]] select _casual;

    //Tyre. The anchor is where the tread gripped: it stretches like a spring until the grip
    //runs out and then slides, so a stopped aircraft stays stopped.
    private _along = vectorNormalized (_fwd vectorDiff (_normal vectorMultiply (_fwd vectorDotProduct _normal)));
    private _side  = _along vectorCrossProduct _normal;

    private _anchor = _anchors select _forEachIndex;
    if (_anchor isEqualTo []) then {_anchor = _contact};
    private _stretch      = _contact vectorDiff _anchor;
    private _stretchAlong = _stretch vectorDotProduct _along;
    private _stretchSide  = _stretch vectorDotProduct _side;
    private _velAlong     = _vel vectorDotProduct _along;
    private _velSide      = _vel vectorDotProduct _side;

    private _tyreMass  = _sprung * 0.5;
    private _tread     = _tyreStiffness * _share;
    private _treadDamp = 2 * sqrt (_tread * _tyreMass);
    private _tyreStep  = _dt / (1 + (((_treadDamp * _dt) + (_tread * _dt * _dt)) / _tyreMass));

    private _held = _hasBrake && _brakeSet;
    private _grip = 0;

    private _forceAlong = 0;
    if (_held) then {
        _forceAlong = -((_tread * _stretchAlong) + (_treadDamp * _velAlong)) * _tyreStep;
        _grip       = _brakeFriction;
    } else {
        private _rolling = _rollingFriction * _load;
        _stretchAlong = 0;
        _forceAlong   = ((-_velAlong * _tyreMass) max -_rolling) min _rolling;
    };

    //The tail wheel swivels free unless the parking brake is set
    private _gripped   = _hasBrake || _brakeSet;
    private _forceSide = 0;
    if (_gripped) then {
        _forceSide = -((_tread * _stretchSide) + (_treadDamp * _velSide)) * _tyreStep;
        _grip      = _grip max _sideFriction;
    } else {
        private _scrub = _casterFriction * _load;
        _stretchSide = 0;
        _forceSide   = ((-_velSide * _tyreMass) max -_scrub) min _scrub;
    };

    private _limit = _grip * _spring * _dt;
    private _used  = vectorMagnitude [[0, _forceAlong] select _held, [0, _forceSide] select _gripped, 0];
    private _slip  = _used > 0 && {_used > _limit};
    if (_slip) then {
        private _scale = _slideRatio * _limit / _used;
        if (_held) then {_forceAlong = _forceAlong * _scale};
        if (_gripped) then {_forceSide = _forceSide * _scale};
        _stretchAlong = _stretchAlong * _scale;
        _stretchSide  = _stretchSide  * _scale;
    };
    _anchors set [_forEachIndex, (_contact vectorDiff (_along vectorMultiply _stretchAlong)) vectorDiff (_side vectorMultiply _stretchSide)];

    private _tyre = (_along vectorMultiply _forceAlong) vectorAdd (_side vectorMultiply _forceSide);
    //The main gear sits ahead of the centre of mass, so side force there ground loops the
    //aircraft. Casual's tyres steer the velocity and leave the yaw to the pedals.
    if (_casual && !_brakeSet) then {
        _heli addForce [_normal vectorMultiply _load, _forceAt];
        _heli addForce [_tyre, _com];
    } else {
        _heli addForce [(_normal vectorMultiply _load) vectorAdd _tyre, _forceAt];
    };

    if (_debug) then {
        _log pushBack [_compression, _strutRate, _load / _dt, _forceAlong / _dt, _forceSide / _dt, _velAlong, _velSide, vectorMagnitude _spin, [0, 1] select _slip, _contact select 2];
    };

    if (BMKHS_FM_DEBUG) then {
        [_heli, _pos, _pos vectorAdd [0, 0, _compression - _extension], "green"] call bmkhs_fnc_debugDrawLine;
    };
} forEach _wheels;

if (_debug) then {
    [_heli, _dt, _log] call fza_ah64_helisim_fnc_suspensionLog;
};
