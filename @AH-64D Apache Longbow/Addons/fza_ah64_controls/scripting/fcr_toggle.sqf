_heli = _this select 0;

if ((isengineon _heli || [_heli] call fza_fnc_engineAPUOn) && (typeof _heli == "fza_ah64d_b2e")) then {
    fza_ah64_fcrstate = fza_ah64_fcrstate + 1;
    if (!(isVehicleRadarOn _heli)) then {
        player action["ActiveSensorsOn", _heli];
    };
    if (fza_ah64_fcrstate > 1) then {
        fza_ah64_fcrstate = 0;
        if (isVehicleRadarOn _heli) then {
            player action["ActiveSensorsOff", _heli];
        };
    };
};