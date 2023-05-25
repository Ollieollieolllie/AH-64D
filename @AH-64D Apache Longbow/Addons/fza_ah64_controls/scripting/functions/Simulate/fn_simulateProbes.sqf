/* ----------------------------------------------------------------------------
Function: fza_fnc_SimulateProbes

Description:
    Simulation of the Air probes attached to the enging covers

Parameters:
    _heli = The apache

Returns:
    Nothing

Examples:
    [_heli] call fza_fnc_SimulateProbes;

Author:
	Rosd6(Dryden), BradMick
---------------------------------------------------------------------------- */
params["_heli"];

if !(player == currentPilot _heli) exitwith {};

/////////////////////////////////////////////////////////////////////
///////Air Probe Simulation    //////////////////////////////////////
/////////////////////////////////////////////////////////////////////

//Input
private _velair = velocity _heli - wind;
private _velmag = vectorMagnitude _velair;
private _vertvect = ((_velair select 2) atan2 sqrt(((_velair select 0) * (_velair select 0)) + ((_velair select 1) * (_velair select 1))));
private _weight = 90;

private _velfactor = _velmag * 0.05;
if (_velfactor > 1) then {_velfactor = 1;};

private _vertvect = (_vertvect * _velfactor) + _weight;
private _helipb = _heli call fza_fnc_getPitchBank;
private _vertvect = (_vertvect - (_helipb select 0));
private _horveldir = abs((velocity _heli select 0) atan2(velocity _heli select 1));
private _theta = (360 + (_horveldir - (direction _heli))) Mod 360;
private _targhead = _theta;
if (_theta >= 180) then {
    _targhead = _theta - 360;
};
private _horvect = (_targhead * _velfactor);

private _vertvect1 = (sin(_helipb select 1)) * _horvect;
private _vertvect2 = (cos(_helipb select 1)) * _vertvect;

private _horvect1 = (cos(_helipb select 1)) * _horvect;
private _horvect2 = (sin(_helipb select 1)) * _vertvect;

//Lerp Smoothing
private _inputP = (_vertvect1 + _vertvect2) * 0.002778;
private _inputY = (_horvect1 + _horvect2) * 0.002778;

private _AirProbePoutput = _heli getvariable ["Fza_ah64_AirProbePoutput", 0];
Private _AirProbePoutput =  [_AirProbePoutput, _inputP, 0.1] call BIS_fnc_lerp; 
_heli setvariable ["Fza_ah64_AirProbePoutput", _AirProbePoutput];

private _AirProbeYoutput = _heli getvariable ["Fza_ah64_AirProbeYoutput", 0];
Private _AirProbeYoutput =  [_AirProbeYoutput, _inputY, 0.1] call BIS_fnc_lerp; 
_heli setvariable ["Fza_ah64_AirProbeYoutput", _AirProbeYoutput];

//Left airprobe
_heli animateSource["l_ads_p", _AirProbePoutput];
_heli animateSource["l_ads_y",  _AirProbeYoutput];

//Right airprobe
_heli animateSource["r_ads_p", _AirProbePoutput];
_heli animateSource["r_ads_y",  _AirProbeYoutput];