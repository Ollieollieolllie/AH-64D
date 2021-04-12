/* ----------------------------------------------------------------------------
Function: fza_fnc_targetingVariable
Description:
	Handles repetitive Heavy Variable management. Should be run in the Slowscheduler.
Parameters:
	_heli - The helicopter to act on
Returns:
	Nothing
Examples:
	--- Code
    [_heli] call fza_fnc_targetingVariable;
	---
Author:
	Rosd6(Dryden)
---------------------------------------------------------------------------- */
params ["_heli"];
if (!(player in _heli)) exitwith {};
private _visibleTargets = [];

//remove dead targets
fza_ah64_pfzs = fza_ah64_pfzs - alldead;
fza_ah64_targetlist = fza_ah64_targetlist - alldead;
fza_ah64_fcrlist = fza_ah64_fcrlist - alldead;

//TSD ATK LIST
if (([_heli, 1] call fza_fnc_mpdGetCurrentDisplay == "tsd") && (_heli getVariable "fza_ah64_tsdmode" == "atk")) then {
	fza_ah64_tsddisptargs = fza_ah64_targetlist select {alive _x};
};

//FCR & CSCOPE LIST
if (([_heli, 1] call fza_fnc_mpdGetCurrentDisplay == "fcr") || (_heli getVariable "fza_ah64_fcrcscope")) then {
	fza_ah64_dispfcrlist = fza_ah64_fcrlist select {
		_distOffAxis = abs ([[_heli, (getposatl _heli select 0), (getposatl _heli select 1), (getposatl _x select 0), (getposatl _x select 1)] call fza_fnc_relativeDirection] call CBA_fnc_simplifyAngle180);

		switch (_heli getVariable "fza_ah64_agmode") do {
			case 1: {
				(((_x isKindOf "plane") || (_x isKindOf "helicopter")) && ((_heli distance2D _x) < 8000))
			};
			default {
			!(((_heli distance2D _x) > 8000) || (_distOffAxis > 45))
			};
		};
	};
};

//ASE LIST
if ([_heli, 1] call fza_fnc_mpdGetCurrentDisplay == "ase") then {
	fza_ah64_asethreatsdraw = fza_ah64_targetlist select {_x call fza_fnc_targetIsADA};
};
fza_ah64_asethreats = vehicles select {_x call fza_fnc_targetIsADA};