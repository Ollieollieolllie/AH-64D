/* ----------------------------------------------------------------------------
Function: fza_ihadss_fnc_nvsBias

Description:
    Correction added to the night vision sensor (PNVS or TADS) a crew station
    drives, so its HDU picture lines up with the world. The pilot's sensors
    are lined up as they are; the CPG's eye is elsewhere, so the CPG has its
    own by the sensor's azimuth, measured in game: in elevation,
    NVS_EL_BIAS_CPG, and with the controls, where the CPG's head moves with
    the aircraft, NVS_BIAS_CPG_FLYING in azimuth and elevation.

Parameters:
    _heli - The helicopter
    _seat - "plt" or "cpg"
    _az   - The sensor's azimuth from the nose (deg)

Returns:
    [azimuth, elevation] (deg)

Examples:
    --- Code
    ([_heli, "cpg", 30] call fza_ihadss_fnc_nvsBias) params ["_azBias", "_elBias"];
    ---

Author:
    Snow(Dryden)
---------------------------------------------------------------------------- */
#include "\fza_ah64_controls\headers\systemConstants.h"
params ["_heli", "_seat", ["_az", 0]];

if (_seat != "cpg") exitWith {[0, 0]};
if (currentPilot _heli != gunner _heli) exitWith {[0, ([NVS_EL_BIAS_CPG, _az] call fza_fnc_linearInterp) # 1]};

([NVS_BIAS_CPG_FLYING, _az] call fza_fnc_linearInterp) params ["", "_azBias", "_elBias"];
[_azBias, _elBias]
