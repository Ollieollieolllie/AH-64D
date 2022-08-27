/* ----------------------------------------------------------------------------
Function: fza_fnc_aseAudioController

Description:
	Handles ASE audio

Parameters:
	heli: Object - Vehicle the event handler is assigned to

Returns:
	Nothing

Examples:
    [_heli] call fza_fnc_aseAudioController

Author:
	BradMick
---------------------------------------------------------------------------- */
params ["_heli"];





















/*

_Counter = _heli getVariable ["fza_ah64_ASEAudiocounter", 0];
_heli setVariable ["fza_ah64_ASEAudiocounter", (_counter + 1) % 5];

{
	_x params ["_ada", "_type", "_sensor"];
	private _IDfailed = true;
	if (_heli getVariable "fza_ah64_apu" || (isEngineOn _heli)) then {
		if (!(_type == "missile") && ("radar" in _sensor) && (alive _ADA)) then {

			if (_type == "locked") then {
				_trackingarray pushBack _ADA;
				
				//confirm ada hostile for team
				_ADA confirmSensorTarget [playerSide, true];

				//ASE autopage
				if (_heli getVariable "fza_ah64_aseautopage" == 1) then {
					[_heli, 1, "ase"] call fza_mpd_fnc_setCurrentPage;
				};

				//audio 
				if (_counter % 5 == 1 && (fza_ah64_Incomingaudio == false)) then {
					if ((_ADA iskindof "rhs_zsutank_base") || (_ADA iskindof "CUP_ZSU23_Base")) then {
						["fza_ah64_zsu23_track", 2.3] spawn fza_fnc_playAudio;
						_IDfailed = false;
						sleep 2.3;
					};
					if (_ADA iskindof "CUP_2S6_Base") then {
						["fza_ah64_2s6_track", 2.3] spawn fza_fnc_playAudio;
						_IDfailed = false;
						sleep 2.3;
					};
					if ((_ADA iskindof "B_APC_Tracked_01_base_F") || (_ADA iskindof "O_APC_Tracked_02_base_F")) then {
						["fza_ah64_bt_sa19", 1.6, "fza_ah64_bt_tracking", 0.65] spawn fza_fnc_playAudio;
						_IDfailed = false;
						sleep 2.25;
					};
					if ((_ADA iskindof "Radar_System_01_base_F") || (_ADA iskindof "Radar_System_02_base_F") || (vehicle _ADA iskindof "SAM_System_03_base_F") || (vehicle _ADA iskindof "SAM_System_04_base_F")) then {
						["fza_ah64_bt_sa9", 1.2, "fza_ah64_bt_tracking", 0.65] spawn fza_fnc_playAudio;
						_IDfailed = false;
						sleep 1.85;
					};
					if (_IDfailed == true) then {
						["fza_ah64_rdr_track", 1.4] spawn fza_fnc_playAudio;
						sleep 1.4;
					};
				};
			};
		};
	};
	sleep 0.1;
} forEach getSensorThreats _heli;

fza_ah64_threattracking = _trackingarray;
fza_ah64_asethreatsdraw = _asearray;