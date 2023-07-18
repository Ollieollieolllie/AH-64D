/* ----------------------------------------------------------------------------
Function: fza_fire_fnc_damageEngineFire

Description:
    damageEngineFire

Parameters:
    _heli - The helicopter to modify
    _eng - the engine that has been assigned to burn

Returns:
    Nothing

Examples:
    --- Code
    [_heli, "right"] spawn fza_fire_fnc_damageEngineFire
    ---

Author:
    Snow(dryden), Mattysmith22
---------------------------------------------------------------------------- */
params ["_heli","_engine"];

_rand = floor random 3;
if (_rand > 1) exitwith {};

private _componentId = "";
switch _eng do {
    case "right": {
        _componentId = "fza_ah64_e2_fire";
    };
    case "left": {
        _componentId = "fza_ah64_e1_fire";
    };
    case "apu": {
        _componentId = "fza_ah64_apu_fire";
    };
};

if (_heli getVariable _componentId) exitwith {};

_heli setVariable[_componentId, true, true];
["fza_engineFire", [_heli, _eng]] call CBA_fnc_globalEvent;

private _primaryFBAvailable = !(_heli getVariable "fza_ah64_firepdisch");
private _reserveFBAvailable = !(_heli getVariable "fza_ah64_firerdisch");
private _primaryFBActioned  = false;
private _reserveFBActioned  = false;

while {
    (alive _heli)
}
do { 
	scopeName "fza_fireHandleScope";
    private _rand = random 10;
    private _primaryFBState = _heli getVariable "fza_ah64_firepdisch";
    private _reserveFBState = _heli getVariable "fza_ah64_firerdisch";
    private _heliDamage = damage _heli;
    if (_primaryFBAvailable == _primaryFBState) then {
      _primaryFBActioned = true;  
    };
    if (_reserveFBAvailable == _reserveFBState) then {
      _reserveFBActioned = true;  
    };
    switch (_eng) do {
        case "left": {
            private _rngine1Arm    = (_heli getVariable "fza_ah64_fireArmed1") #0;
            private _powerLevelPos = _heli getVariable "fza_sfmplus_engPowerLeverState" select 0;
            private _engineDamage  = _heli getHitPointDamage "hitengine1";
            if (_engine1Arm && (_primaryFBActioned || _reserveFBActioned)) then {breakOut  "fza_fireHandleScope"};
            if ((_powerLevelPos == "off") && _rand >= 9.9) then {breakOut  "fza_fireHandleScope"};
            _heli setHitPointDamage ["hitengine1", _engineDamage + 0.001];
            if (_engineDamage == 1) then {
                _heli setdamage _heliDamage + 0.001;
            };
        };
        case "right": {
            private _engine2Arm    = (_heli getVariable "fza_ah64_fireArmed2") #0;
            private _powerLevelPos = _heli getVariable "fza_sfmplus_engPowerLeverState" select 1;
            private _engineDamage  = _heli getHitPointDamage "hitengine2";
            if (_engine2Arm && (_primaryFBActioned || _reserveFBActioned)) then {breakOut  "fza_fireHandleScope"};
            if ((_powerLevelPos == "off") && _rand >= 9.9) then {breakOut  "fza_fireHandleScope"};
            _heli setHitPointDamage ["hitengine2", _engineDamage + 0.001];
            if (_engineDamage == 1) then {
                _heli setdamage _heliDamage + 0.001;
            };
        };
        case "apu": {
            private _engineApuArm = (_heli getVariable "fza_ah64_fireArmedApu") #0;
            private _apuOn        = _heli getVariable "fza_systems_apuOn";
            private _apuDamage    = _heli getHitPointDamage "hit_apu";
            if (_engineApuArm && (_primaryFBActioned || _reserveFBActioned)) then {breakOut  "fza_fireHandleScope"};
            if (!_apuOn && _rand >= 9.9) then {breakOut  "fza_fireHandleScope"};
            _heli setHitPointDamage ["hit_apu", _apuDamage + 0.001];
            if (_apuDamage == 1) then {
                _heli setdamage _heliDamage + 0.001;
            };
        };
    };
    sleep 0.1;
};

["fza_engineFireOut", [_heli, _eng]] call CBA_fnc_globalEvent;
_heli setVariable[_componentId, false, true];