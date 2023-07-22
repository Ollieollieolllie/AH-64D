/* ----------------------------------------------------------------------------
Function: fza_fnc_fxLoops

Description:
    loops battery or apu audio

Parameters:

Returns:
    Nothing
    
Examples:
    [_heli] spawn fza_fnc_fxLoops;

Author:
    Unknown
---------------------------------------------------------------------------- */
params["_heli", "_system"];

private _apuOn     = _heli getVariable "fza_systems_apuOn";
private _battBusOn = _heli getVariable "fza_systems_battBusOn";
private _timed_apu = CBA_missionTime + 24;
private _timed_bat = CBA_missionTime;

if (_system == "apu") then {
    private _apu = "fza_ah64_1200Magazine" createVehicle position _heli;
    _apu attachTo [_heli, [0, 0, 0]];
    hideObjectGlobal _apu;

    //APU START
    _apu say3D ["fza_ah64_apustart_3D", 200];
    
    //APU ON
    while {_apuOn;}
    do {
        if (CBA_missionTime > _timed_apu) then {
            _timed_apu = CBA_missionTime + 60;
            _apu say3D ["fza_ah64_apu_loop_3D", 200];
        };
        sleep 1;
    };
    deleteVehicle _apu;

    //APU Stop
    private _apu = "fza_ah64_1200Magazine" createVehicle position _heli;
    private _timed_apu = CBA_missionTime + 20;
    _apu attachTo [_heli, [0, 0, 0]];
    hideObjectGlobal _apu;
    _apu say3D ["fza_ah64_apustart_3D", 200];
    waitUntil {(_apuOn || CBA_missionTime > _timed_apu);};
    deleteVehicle _apu;
};

if (_system == "battery") then {
    private _bat = "fza_ah64_1200Magazine" createVehicle[0, 0, 0];
    _bat attachTo[_heli, [0, 5, 0]];
    hideObjectGlobal _bat;

    while {_battBusOn;}
    do {
        if (CBA_missionTime > _timed_bat) then {
            _timed_bat = CBA_missionTime + 28;
            [_bat, ["fza_ah64_bat_loop_3D", 10]] remoteExec["say3d"];
        };
        sleep 1;
    };
    deleteVehicle _bat;
};