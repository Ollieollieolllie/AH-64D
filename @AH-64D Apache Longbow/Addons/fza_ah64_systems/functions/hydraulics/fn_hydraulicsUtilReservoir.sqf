/* ----------------------------------------------------------------------------
Function: fza_systems_fnc_hydraulicsPriReservoir

Description:
    Updates all of the modules core functions.
    
Parameters:
    _heli - The helicopter to get information from [Unit].

Returns:
    ...

Examples:
    ...

Author:
    BradMick
---------------------------------------------------------------------------- */
params ["_heli", "_deltaTime"];
#include "\fza_ah64_systems\headers\systems.hpp"

private _utilReservoirDamage = _heli getHitPointDamage "hit_hyd_utilReservoir";
private _utilHydLevel_pct    = _heli getVariable "fza_systems_utilLevel_pct";
private _curLeakTimer       = 0.0;
private _leakTimer          = _heli getVariable "fza_systems_hydLeakTimer";

//Small leak
if (_utilReservoirDamage > SYS_HYD_RES_MIN_DMG && _utilReservoirDamage <= SYS_HYD_RES_MOD_DMG) then {
    _curLeakTimer = _leakTimer;
};
//Medium leak
if (_utilReservoirDamage > SYS_HYD_RES_MOD_DMG && _utilReservoirDamage <= SYS_HYD_RES_HVY_DMG) then {
    _curLeakTimer = _leakTimer * 0.75;
};
//Large leak
if (_utilReservoirDamage > SYS_HYD_RES_HVY_DMG) then {
    _curLeakTimer = _leakTimer * 0.5;
};
//Leak
if (_utilReservoirDamage > SYS_HYD_RES_MIN_DMG) then {
    _utilHydLevel_pct = [_utilHydLevel_pct, 0.0, (1 / _curLeakTimer) * _deltaTime] call BIS_fnc_lerp;
};

if (_utilHydLevel_pct < SYS_HYD_MIN_LVL) then {
    //CALL WCA here
};

_heli setVariable ["fza_systems_utilLevel_pct",  _utilHydLevel_pct];