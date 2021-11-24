/* ----------------------------------------------------------------------------
Function: fza_sfmplus_fnc_engineController

Description:
	Monitors and controls engine states.

Parameters:
	_heli      - The helicopter to get information from [Unit].
	_deltaTime - Passed delta time from core update.

Returns:
	...

Examples:
	...

Author:
	BradMick
---------------------------------------------------------------------------- */
params ["_heli", "_deltaTime"];

private _engState  = _heli getVariable "fza_sfmplus_engState";
private _eng1State = _engState select 0;
private _eng2State = _engState select 1;

if ((_eng1State == "STARTING" || _eng2State == "STARTING") && local _heli) then {
	_heli setVariable ["fza_ah64_estarted", true, true];
	_heli engineOn true;
};

private _isSingleEng     = _heli getVariable "fza_sfmplus_isSingleEng";
private _engPwrLvrState  = _heli getVariable "fza_sfmplus_engPowerLeverState";
private _eng1PwrLvrState = _engPwrLvrState select 0;
private _eng2PwrLvrState = _engPwrLvrState select 1;

private _eng1TqMult = 1;
private _eng2TqMult = 1;

if ((_eng1State == "ON" && _eng1PwrLvrState == "IDLE") && (_eng2State == "ON" && _eng2PwrLvrState == "IDLE")) then {
	_isSingleEng = false;
} else {
	if (_eng1State == "ON" && _eng2PwrLvrState in ["OFF", "IDLE"]) then {
		_eng1TqMult = 2;
		_eng2TqMult = 0;
		_isSingleEng = true;
	};

	if (_eng2State == "ON" && _eng1PwrLvrState in ["OFF", "IDLE"]) then {
		_eng1TqMult = 0;
		_eng2TqMult = 2;
		_isSingleEng = true;
	};
};

if ((_eng1State == "ON" && _eng2State == "ON") && (_eng1PwrLvrState == "FLY" && _eng2PwrLvrState == "FLY")) then {
	_isSingleEng = false;
};

_heli setVariable ["fza_sfmplus_isSingleEng", _isSingleEng];

if (isMultiplayer && local _heli && (_heli getVariable "fza_sfmplus_lastTimePropagated") + 5 < time) then {
	{
		_heli setVariable [_x, _heli getVariable _x, true];
	} forEach [
		"fza_sfmplus_engFF",
		"fza_sfmplus_engBaseNG",
		"fza_sfmplus_engPctNG",
		"fza_sfmplus_engBaseNP",
		"fza_sfmplus_engPctNP",
		"fza_sfmplus_engBaseTQ",
		"fza_sfmplus_engPctTQ",
		"fza_sfmplus_engBaseTGT",
		"fza_sfmplus_engTGT",
		"fza_sfmplus_engBaseOilPSI",
		"fza_sfmplus_engOilPSI",
		"fza_sfmplus_engDest"
	];
	_heli setVariable ["fza_sfmplus_lastTimePropagated", time, true];
};

[_heli, 0, _deltaTime, _eng1TqMult] call fza_sfmplus_fnc_engine;
[_heli, 1, _deltaTime, _eng2TqMult] call fza_sfmplus_fnc_engine;

if (_eng1State == "OFF" && _eng2State == "OFF" && local _heli) then {
	_heli setVariable ["fza_ah64_estarted", false, true];
	_heli engineOn false;
};