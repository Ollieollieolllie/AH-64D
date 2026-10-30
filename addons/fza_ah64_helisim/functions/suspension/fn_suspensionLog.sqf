/* ----------------------------------------------------------------------------
Function: fza_ah64_helisim_fnc_suspensionLog

Description:
    With the Suspension log setting on, writes the landing gear to the RPT as
    comma-separated FZASUSP lines. A FZASUSP_HDR line names the columns, once
    per aircraft and whenever the log is switched on.

Parameters:
    _heli  - The helicopter [Object]
    _dt    - Frame time the gear was solved over, s [Number]
    _rows  - For each wheel, the values named in _wheelCols [Array]

Returns:
    Nothing
---------------------------------------------------------------------------- */
params ["_heli", "_dt", "_rows"];

if (fza_ah64_suspensionDebug == 1 && {time < (_heli getVariable ["fza_ah64_suspLogLast", -1]) + 0.1}) exitWith {};
_heli setVariable ["fza_ah64_suspLogLast", time];

if !(_heli getVariable ["fza_ah64_suspLogHdr", false]) then {
    _heli setVariable ["fza_ah64_suspLogHdr", true];
    private _wheelCols = ["comp", "strutRate", "load", "along", "side", "velAlong", "velSide", "spin", "slip", "z"];
    private _cols = [
        "t", "frame", "dt", "fps", "accTime", "x", "y", "pitch", "bank", "hdg",
        "vx", "vy", "vz", "wx", "wy", "wz", "mass", "comY", "comZ",
        "brake", "coll", "cyclic", "cyclicLat", "pedal", "sasYaw", "hdgHold", "autoPedal", "nr", "realism",
        "touching", "onGnd", "radAlt", "getPosZ"
    ];
    {
        private _wheel = _x;
        _cols append (_wheelCols apply {format ["%1%2", _wheel, _x]});
    } forEach ["R_", "L_", "T_"];
    diag_log ("FZASUSP_HDR," + (_cols joinString ","));
};

(_heli call BIS_fnc_getPitchBank) params ["_pitch", "_bank"];
private _pos = getPosASL _heli;
private _com = getCenterOfMass _heli;

private _row = [
    CBA_missionTime toFixed 3, diag_frameNo, _dt toFixed 4, diag_fps toFixed 1, accTime,
    (_pos select 0) toFixed 2, (_pos select 1) toFixed 2,
    _pitch toFixed 3, _bank toFixed 3, (getDir _heli) toFixed 2
];
_row append ((velocityModelSpace _heli) apply {_x toFixed 3});
_row append ((angularVelocityModelSpace _heli) apply {_x toFixed 4});
_row append [
    round getMass _heli, (_com select 1) toFixed 3, (_com select 2) toFixed 3,
    [0, 1] select (_heli getVariable ["fza_ah64_parkingBrake", true]),
    (_heli getVariable ["bmkhs_collectiveOutput", 0]) toFixed 3,
    (_heli getVariable ["bmkhs_cyclicFwdAft", 0]) toFixed 3,
    (_heli getVariable ["bmkhs_cyclicLeftRight", 0]) toFixed 3,
    (_heli getVariable ["bmkhs_pedalLeftRight", 0]) toFixed 3,
    (_heli getVariable ["bmkhs_fmcSasYawOut", 0]) toFixed 3,
    (_heli getVariable ["bmkhs_fmcHdgHoldPedalYawOut", 0]) toFixed 3,
    (_heli getVariable ["bmkhs_autoPedalPos", 0]) toFixed 3,
    (_heli getVariable ["bmkhs_rtrRpm", 0]) toFixed 3,
    bmkhs_helisimRealismSetting,
    [0, 1] select isTouchingGround _heli,
    [0, 1] select ([_heli] call bmkhs_fnc_stateOnGround),
    (_heli getVariable ["bmkhs_radAlt", 0]) toFixed 3,
    (getPos _heli select 2) toFixed 3
];

{
    _x params ["_comp", "_strutRate", "_load", "_along", "_side", "_velAlong", "_velSide", "_spin", "_slip", "_z"];
    _row append [
        _comp toFixed 4, _strutRate toFixed 3, round _load, round _along, round _side,
        _velAlong toFixed 3, _velSide toFixed 3, _spin toFixed 3, _slip, _z toFixed 4
    ];
} forEach _rows;

diag_log ("FZASUSP," + (_row joinString ","));
