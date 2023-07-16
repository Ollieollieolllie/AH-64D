/* ----------------------------------------------------------------------------
Function: fza_aiCrew_fnc_fireControl


Description:
    handles the ai controls sequence for putting out fires
    fire suppresion does not work on full ai crew so it is disabled for full ai crew

Parameters:
    Heli: Object - The helicopter to modify

Returns:
    Nothing

Examples:
    --- Code
    [_this] spawn fza_aiCrew_fnc_fireControl
    ---

Author:
    Snow(Dryden)
---------------------------------------------------------------------------- */
params ["_heli"];
#include "\fza_ah64_controls\headers\script_common.hpp"

if !fza_ah64_aiFirecontrol exitwith {};
if (_heli getVariable "fza_ah64_aiFireHandling") exitWith {}; //Prevent this from being run multiple times simultaneously
_heli setVariable ["fza_ah64_aiFireHandling", true];

_driver = driver vehicle _heli;
_gunner = gunner vehicle _heli;
if !((alive _driver && !isPlayer _driver) || (alive _gunner && !isPlayer _gunner)) exitWith {};

Private _PrimaryFBAvailable = !(_heli getVariable "fza_ah64_firepdisch");
Private _ReserveFBAvailable = !(_heli getVariable "fza_ah64_firerdisch");


sleep fza_ah64_aiFireResponse;
if !(_heli getVariable "fza_ah64_e1_fire" || _heli getVariable "fza_ah64_e2_fire" || _heli getVariable "fza_ah64_apu_fire") exitWith {};
if (_heli getVariable "fza_ah64_e1_fire") then {
    [_heli, "eng1", true] call fza_fire_fnc_HandlePanel;
};
sleep 0.4;
if (_heli getVariable "fza_ah64_e2_fire") then {
    [_heli, "eng2", true] call fza_fire_fnc_HandlePanel;
};
sleep 0.4;
if (_heli getVariable "fza_ah64_apu_fire") then {
    [_heli, "apu", true] call fza_fire_fnc_HandlePanel;
};
sleep 0.4;
if (_heli getVariable "fza_ah64_e1_fire" || _heli getVariable "fza_ah64_e2_fire" || _heli getVariable "fza_ah64_apu_fire") then {
    if _PrimaryFBAvailable then {
        _heli setVariable ["fza_ah64_firepdisch", true, true];
        if (_heli getHitPointDamage "hitengine2" isNotEqualTo 0) then {
            _heli setHitPointDamage  ["hitengine2", 0.01];
        };
    } else {
        sleep 1;
        if (_heli getVariable "fza_ah64_e1_fire" || _heli getVariable "fza_ah64_e2_fire" || _heli getVariable "fza_ah64_apu_fire") then {
            if !_ReserveFBAvailable then {
                _heli setVariable ["fza_ah64_firerdisch", true, true];
                if (_heli getHitPointDamage "hitengine2" isNotEqualTo 0) then {
                    _heli setHitPointDamage  ["hitengine2", 0.01];
                };
            };
        };
    };
};
sleep 3;
[_heli, "eng1", false] call fza_fire_fnc_HandlePanel;
sleep 0.4;
[_heli, "eng2", false] call fza_fire_fnc_HandlePanel;
sleep 0.4;
[_heli, "apu", false] call fza_fire_fnc_HandlePanel;

_heli setVariable ["fza_ah64_aiFireHandling", false];