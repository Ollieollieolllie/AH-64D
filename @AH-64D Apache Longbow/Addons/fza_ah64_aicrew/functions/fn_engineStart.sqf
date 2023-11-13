/* ----------------------------------------------------------------------------
Function: fza_aiCrew_fnc_engineStart


Description:
    Engine event handler, stops the engines from being turned on using the action menu if they shouldn't be on according to the simulated startup sequence.

Parameters:
    (format of the engine event <https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Engine>)
    heli: Object - The helicopter to modify
    engineState: Boolean - True when the engine is turned on, false when turned off

Returns:
    Nothing

Examples:
    --- Code
    [_heli, true] call fza_aiCrew_fnc_Enginestart;
    ---

Author:
    Snow(Dryden)
---------------------------------------------------------------------------- */
params ["_heli", "_engineState"];
systemChat str _heli;
systemChat str _engineState;

if !(!(isPlayer driver _heli) || (alive driver _heli) || (currentpilot _heli == driver _heli)) exitWith {};

switch (_engineState) do {
    case true: {
        [_heli, "fza_ah64_rtrbrake", false] call fza_fnc_animSetValue;
        _heli setVariable ["fza_systems_battSwitchOn",  true, true];
        sleep 3;
        if !((!isPlayer driver _heli) && (alive driver _heli) && (currentpilot _heli == driver _heli)) exitWith {};
        _heli setVariable ["fza_systems_apuBtnOn", true, true];

        sleep 10;
        if !((!isPlayer driver _heli) && (alive driver _heli) && (currentpilot _heli == driver _heli)) exitWith {};
        [_heli, "fza_sfmplus_engState", 0, "STARTING", true] call fza_fnc_setArrayVariable;

        sleep 4;
        if !((!isPlayer driver _heli) && (alive driver _heli) && (currentpilot _heli == driver _heli)) exitWith {};
        [_heli, 0, "IDLE"] spawn fza_sfmplus_fnc_interactPowerLever;

        sleep 6;
        if !((!isPlayer driver _heli) && (alive driver _heli) && (currentpilot _heli == driver _heli)) exitWith {};
        [_heli, "fza_sfmplus_engState", 1, "STARTING", true] call fza_fnc_setArrayVariable;

        sleep 4;
        if !((!isPlayer driver _heli) && (alive driver _heli) && (currentpilot _heli == driver _heli)) exitWith {};
        [_heli, 1, "IDLE"] call fza_sfmplus_fnc_interactPowerLever;

        sleep 12;
        if !((!isPlayer driver _heli) && (alive driver _heli) && (currentpilot _heli == driver _heli)) exitWith {};
        [_heli, 0, "FLY"] call fza_sfmplus_fnc_interactPowerLever;
        [_heli, 1, "FLY"] call fza_sfmplus_fnc_interactPowerLever;

        sleep 10;
        if !((!isPlayer driver _heli) && (alive driver _heli) && (currentpilot _heli == driver _heli)) exitWith {};
        _heli setVariable ["fza_systems_apuBtnOn", false, true];
    };
    case false: {
        _heli setVariable ["fza_sfmplus_engState",              ["OFF", "OFF"]];
        _heli setVariable ["fza_sfmplus_engPowerLeverState",    ["OFF", "OFF"]];
        [_heli, "fza_ah64_powerLever1", 0, 10] call fza_fnc_animSetValue;
        [_heli, "fza_ah64_powerLever2", 0, 10] call fza_fnc_animSetValue;
        _heli setVariable ["fza_systems_apuBtnOn", false, true];
        _heli engineon false;
    };
};