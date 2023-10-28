/* ----------------------------------------------------------------------------
Function: fza_ufd_fnc_update

Description:
    handles the ufd textures
    
Parameters:

Returns:
    Nothing
    
Examples:
    [_heli] spawn fza_fnc_Ufd;

Author:
    Unknown
---------------------------------------------------------------------------- */
params ["_heli"];
#include "\fza_ah64_mpd\headers\mfdConstants.h"
#include "\fza_ah64_controls\headers\wcaConstants.h"
if (!(isNil "fza_ah64_noufd")) exitwith {};

if (!(_heli getVariable ["fza_ah64_aircraftInitialised", false]) || ((driver _heli != player && gunner _heli != player)) || !(_heli iskindof "fza_ah64base")) exitwith {};

///end gunner weapon damage//
private _battBusOn = _heli getVariable "fza_systems_battBusOn";
private _dcBusOn   = _heli getVariable "fza_systems_dcBusOn";

if (_heli getVariable "fza_ah64_rdp_fail" && !(_heli getVariable "fza_ah64_ldp_fail") && [_heli, 0] call fza_mpd_fnc_currentPage != "fail") then {
    [_heli, 1, "fail"] call fza_mpd_fnc_setCurrentPage;
};
if (_heli getVariable "fza_ah64_ldp_fail" && !(_heli getVariable "fza_ah64_rdp_fail") && [_heli, 1] call fza_mpd_fnc_currentPage != "fail") then {
    [_heli, 0, "fail"] call fza_mpd_fnc_setCurrentPage;
};
if (_heli getVariable "fza_ah64_e1_fire") then {
    _heli setobjecttexture ["in_lt_fire1", "\fza_ah64_us\tex\in\pushbut.paa"];
} else {
    _heli setobjecttexture ["in_lt_fire1", ""];
};
if (_heli getVariable "fza_ah64_e2_fire") then {
    _heli setobjecttexture ["in_lt_fire2", "\fza_ah64_us\tex\in\pushbut.paa"];
} else {
    _heli setobjecttexture ["in_lt_fire2", ""];
};
if (_heli getVariable "fza_ah64_apu_fire") then {
    _heli setobjecttexture ["in_lt_fireapu", "\fza_ah64_us\tex\in\pushbut.paa"];
} else {
    _heli setobjecttexture ["in_lt_fireapu", ""];
};
if (_heli getVariable "fza_ah64_firepdisch") then {
    _heli setobjecttexture ["in_lt_firepdis", "\fza_ah64_us\tex\in\pushbut.paa"];
};
if (_heli getVariable "fza_ah64_firerdisch") then {
    _heli setobjecttexture ["in_lt_firerdis", "\fza_ah64_us\tex\in\pushbut.paa"];
};

///EWCA//
//pilot
if (_battBusOn || _dcBusOn) then {
    _heli setUserMFDValue [MFD_IND_BATT, 1];
    private _wcas = ([_heli] call fza_fnc_coreGetWCAs) select {_x # 2 != ""}; //Removes any WCAs that shouldn't be shown on the EUFD
    private _warnings = (_wcas select {_x # 0 == WCA_WARNING}) apply {_x # 2};
    private _cautions = (_wcas select {_x # 0 == WCA_CAUTION}) apply {_x # 2};
    private _advisories = (_wcas select {_x # 0 == WCA_ADVISORY}) apply {_x # 2};

    private _blankWarning  = "         ";     //9
    private _blankCaution  = "             "; //13
    private _blankAdvisory = "           ";   //11

    for "_i" from 0 to 5 do {
        _heli setUserMFDText [MFD_TEXT_IND_UFDTEXT0 + _i, format["%1|%2|%3",
            if (count _warnings > _i) then {[_warnings # _i, _blankWarning, true] call fza_fnc_padString} else {_blankWarning},       
            if (count _cautions > _i) then {[_cautions # _i, _blankCaution, true] call fza_fnc_padString} else {_blankCaution},
            if (count _advisories > _i) then {[_advisories # _i, _blankAdvisory, true] call fza_fnc_padString} else {_blankAdvisory}
        ]];
    };

    if (isClass(configFile >> "cfgPatches" >> "acre_main") && {[_heli] call acre_api_fnc_areVehicleRacksInitialized}) then { //ACRE compatibility
        private _ptts = [] call acre_api_fnc_getMultiPushToTalkAssignment;
        private _racks = [_heli] call acre_api_fnc_getVehicleRacks;
        private _radios = _racks apply {[_x] call acre_api_fnc_getMountedRackRadio};
        private _radioNames = ["VH", "UH", "F1", "F2"];
        private _radioOther = ["     L1", "C3   L2", "C5 H T1", "C2   L3"];
        {
            private _radio = _x;
            private _radioBase = [_x] call acre_api_fnc_getBaseRadio;
            private _radioChannel =  [_x] call acre_api_fnc_getRadioChannel;
            private _radioPreset = [_x] call acre_api_fnc_getPreset;
            private _ptt = _ptts findIf {_x == _radio};
            private _transmit = if (_ptt == -1 || _ptt >= 3) then {"<"} else {str (_ptt+1)};
            private _radioName = _radioNames # _forEachIndex;
            private _frequencyTX = ([_radio, "getCurrentChannelData"] call acre_sys_data_fnc_dataEvent) getVariable "frequencyTx";
            private _label = [_radioBase, "default", _radioChannel, "label"] call acre_api_fnc_getPresetChannelField;
            if (isNil "_label") then {_label = "     "};
            private _frequencyTXOut = [[_frequencyTX, 0, 3, false] call CBA_fnc_formatNumber, 7] call fza_fnc_padString;
            private _radioChannelOut = [str _radioChannel, 6] call fza_fnc_padString;
            private _labelOut = [_label select [0, 5], 5] call fza_fnc_padString; 
            _heli setUserMFDText [MFD_TEXT_IND_UFDTEXT0 + 5 + _forEachIndex, format["%1-%2 %3* %4 %5 %6 "
                ,_transmit, _radioName, _frequencyTXOut, _labelOut, _radioOther # _forEachIndex, _radioChannel
            ]];
        } forEach _radios;
    } else {
        _heli setUserMFDText [5, "<>VH 139.500* -GO--      L1 149.500"]; 
        _heli setUserMFDText [6, "<>UH 240.500* -FCK- C3   L2 249.500"]; 
        _heli setUserMFDText [7, "<>F1  39.075  -UR-- C5 H T1  45.500"]; 
        _heli setUserMFDText [8, "<>F2  49.500  -SLF- C2   L3  69.525"];
    };

    if (_heli getVariable "fza_ah64_IAFSInstalled") then {
        _heli setUserMFDValue [MFD_IND_IAFS_INSTALLED, 1];
    } else {
        _heli setUserMFDValue [MFD_IND_IAFS_INSTALLED, 0];
    };
} else {
    _heli setUserMFDValue [MFD_IND_BATT, 0]; //isClass(configFile >> "cfgPatches" >> "acre_main");
};