/* ----------------------------------------------------------------------------
Function: fza_aiCrew_fnc_getout


Description:

Parameters:
    heli: Object - Vehicle the event handler is assigned to
    role: String - Can be either "driver", "gunner" or "cargo"
    unit: Object - Unit that left the vehicle
    turret: Array - turret path

Returns:
    Nothing

Examples:
    [_heli] call fza_aiCrew_fnc_getout

Author:
    Snow(Dryden)
---------------------------------------------------------------------------- */
params ["_heli", "_role", "_unit", "_turret"];

if (isplayer _unit) exitWith {};

if (_unit == driver _heli) then {
    _heli animateSource ["pdoor", 1];
};

if (_unit == gunner _heli) then {
    _heli animateSource ["gdoor", 1];
};