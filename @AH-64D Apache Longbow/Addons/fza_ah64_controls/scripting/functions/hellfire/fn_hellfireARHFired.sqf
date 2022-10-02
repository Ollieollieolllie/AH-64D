/* ----------------------------------------------------------------------------
Function: fza_fnc_hellfireARHFired

Description:
    Sets the Seaker params for out custome ARH hellfire seeker head

Parameters:
    _heli - The helicopter to modify

Returns:
	Nothing

Examples:
	Nothing

Author:
	Rosd6(Dryden)
---------------------------------------------------------------------------- */
params ["_firedEH", "_launchParams", "", "", "_stateParams"];
_firedEH params ["_shooter","","","","","","_projectile"];
_stateParams params ["", "_seekerStateParams"];
_launchParams params ["","_targetLaunchParams"];
_targetLaunchParams params ["_target"];

private _heli 			= vehicle _shooter;
private _targinfo       = _heli getVariable "fza_ah64_fcrNts";
private _targObj        = _targinfo #0;
private _targPos        = _targinfo #1;
private _targetType     = _targobj call BIS_fnc_objectType;
private _missilelobl    = _heli getVariable "fza_ah64_missleLOBL";

if (!(isNull _targObj) && _missilelobl == true) then {
	_targPos = getposasl _targObj;
} else {
	_targObj = Objnull;
};

//Cycle Radar targets
private _fcrTargets = _heli getVariable "fza_ah64_fcrTargets";
if (count _fcrTargets == 0) then {
    _heli setVariable ["fza_ah64_fcrNts", [objNull,[0,0,0]], true];
} else {
    private _oldNts = _heli getVariable "fza_ah64_fcrNts";
    private _oldNts = _oldNts # 0;
    private _oldNtsIndex = _fcrTargets findIf {_x # 3 == _oldNts};
    private _newNtsIndex = (_oldNtsIndex + 1) mod count _fcrTargets;
    _heli setVariable ["fza_ah64_fcrNts", [_fcrTargets # _newNtsIndex # 3,_fcrTargets # _newNtsIndex # 0], true];
};


//Dir Trajectorie at close range
_attackProfile = "hellfire_hi";
if (_missilelobl == true && (_targPos distance2d _heli) <= 1400) then {
	_attackProfile = "hellfire";
};

_launchParams set [3, _attackProfile];
_seekerStateParams set [0, _targObj];
_seekerStateParams set [1, _targPos];
_seekerStateParams set [2, _targetType];
_seekerStateParams set [3, _missilelobl];