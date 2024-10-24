/* ----------------------------------------------------------------------------
Function: fza_ase_fnc_rlwr


Description:
    Handles the Radar/Laser Warning Receiver

Parameters:
    heli: Object - Vehicle the event handler is assigned to

Returns:
    Nothing

Examples:
    [_heli] call fza_ase_fnc_rlwr

Author:
    BradMick
---------------------------------------------------------------------------- */
#include "\fza_ah64_controls\headers\systemConstants.h"

params ["_heli"];

private _rlwrPwr     = _heli getVariable "fza_ah64_ase_rlwrPwr";
private _rlwrObjects = [];
private _rlwrCount   = 0;
private _rlwrAudio   = [];

//If the RLWR is on
if (_rlwrPwr == "on") then {
    //Sensor targets - Search
    {
        _x params ["_target", "_type", "_relationship", "_sensor"];
        private _distance_m = _heli distance2d _target;
        //Search
        if ("passiveradar" in _sensor) then {
            if (_distance_m <= ASE_DETECT_RANGE_M) then {
                _rlwrObjects pushBack [ASE_SRH, _heli getRelDir _target];
                _rlwrAudio pushback [vehicle _target, "searching"];
            };
        };
    } foreach getSensorTargets _heli;

    //Sensor threats - acquisition, Track and Launch
    {
        _x params ["_object", "_type", "_sensor"];
        private _distance_m = _heli distance2d _object;
        //acquisition
        if ("marked" in _type) then {
            if (_distance_m <= ASE_DETECT_RANGE_M) then {
                _rlwrObjects pushBack [ASE_ACQ, _heli getRelDir _object];
                _rlwrAudio pushback [vehicle _object, "acquisition"];
            };
        };
        //Track
        if ("locked" in _type) then {
            if (_distance_m <= ASE_DETECT_RANGE_M) then {
                _rlwrObjects pushBack [ASE_TRK, _heli getRelDir _object];
                _rlwrAudio pushback [vehicle _object, "tracking"];
            };
        };
        //Launch
        if (_type == "missile") then {
            private _seekerhead = getNumber (configFile >> "CfgAmmo" >> typeof _object >> "weaponLockSystem");
            if ([_seekerhead, 8] call BIS_fnc_bitwiseAND != 0) then {
                if (_distance_m <= ASE_DETECT_RANGE_M) then {
                    _rlwrObjects pushBack [ASE_LNC, _heli getRelDir _object];
                };
            };
        };
    } foreach getSensorThreats _heli;
    _rlwrObjects = [_rlwrObjects, [], {_x # 0}, "DESCEND"] call BIS_fnc_sortBy;
} else { _rlwrObjects = []; };
_heli setVariable ["fza_ah64_ase_rlwrObjects", _rlwrObjects];
_rlwrCount = count _rlwrObjects;
_heli setVariable ["fza_ah64_ase_rlwrCount", _rlwrCount];

[_heli,_rlwrAudio] spawn fza_ase_fnc_audioController;