#include "\fza_ah64_controls\headers\script_common.hpp"
#include "\fza_ah64_controls\headers\systemConstants.h"
params ["_heli", "_mpdIndex", "_control"];

switch(_control) do {
    //Chaff
    case "t1": {
        private _newState = ["safe", "arm"] select (_heli getVariable "fza_ah64_ase_chaffState" == "safe");
        _heli setVariable ["fza_ah64_ase_chaffState", _newState];
    };
    //IR Jammer
    case "r1": {
        private _newState = ["off", "on"] select (_heli getVariable "fza_ah64_ase_irjamPwr" == "off");
        _heli setVariable ["fza_ah64_ase_irJamPwr", _newState];
    };
    //RLWR
    case "r6": {
        private _newState = ["off", "on"] select (_heli getVariable "fza_ah64_ase_rlwrPwr" == "off");
        _heli setVariable ["fza_ah64_ase_rlwrPwr", _newState];
        if (_newstate == "on") then {
            [_heli, 7, "APR-39", "fza_ah64_APR_39_power_up", 1.8] call fza_audio_fnc_addASEMessage;
        };
    };
    case "t2": {
        [_heli, _mpdIndex, "tsd"] call fza_mpd_fnc_setCurrentPage;
    };
    case "b1": {
        [_heli, _mpdIndex, "tsd"] call fza_mpd_fnc_setCurrentPage;
    };
    //Autopage
    case "l3": {
        _heli setVariable ["fza_ah64_ase_autopage", ASE_AUTOPAGE_SRH];
    };
    case "l4": {
        _heli setVariable ["fza_ah64_ase_autopage", ASE_AUTOPAGE_ACQ];
    };
    case "l5": {
        _heli setVariable ["fza_ah64_ase_autopage", ASE_AUTOPAGE_TRK];
    };
    case "l6": {
        _heli setVariable ["fza_ah64_ase_autopage", ASE_AUTOPAGE_OFF];
    };
};