/* ----------------------------------------------------------------------------
Function: fza_ah64_helisim_fnc_suspensionVariables

Description:
    Reads the landing gear from config and sets up its per-aircraft state.

Parameters:
    _heli - The helicopter [Object]

Returns:
    Nothing
---------------------------------------------------------------------------- */
#include "\bmkhs_helisim\functions\core\core.hpp"

params ["_heli"];

private _config       = configOf _heli >> "BMKHS_HeliSim" >> "Suspension";
private _designMass   = getNumber (_config >> "designMass");
private _gasExponent  = getNumber (_config >> "gasExponent");
private _dampingRatio = getNumber (_config >> "dampingRatio");

private _wheels = ("true" configClasses (_config >> "Wheels")) apply {
    private _share      = getNumber (_x >> "loadShare");
    private _gasLength  = getNumber (_x >> "gasLength");
    private _extension  = getNumber (_x >> "extension");
    private _staticLoad = _designMass * GRAVITY * _share;
    //What the gas curve still pushes with at full extension, taken off so the strut's force
    //fades to nothing as the wheel leaves the ground rather than stepping down to it
    private _preload    = (_gasLength / (_gasLength + _extension)) ^ _gasExponent;
    private _rate       = _gasExponent * _staticLoad / (_gasLength * (1 - _preload));
    [
        getArray  (_x >> "position"),
        _extension,
        getNumber (_x >> "travel"),
        _gasLength,
        _share,
        getNumber (_x >> "brake") == 1,
        _staticLoad,
        2 * _dampingRatio * sqrt (_rate * _designMass * _share),
        _preload
    ]
};

_heli setVariable ["fza_ah64_suspWheels", _wheels];
_heli setVariable ["fza_ah64_suspTuning", [
    _gasExponent,
    getNumber (_config >> "dampingLimit"),
    getNumber (_config >> "sealFriction"),
    getNumber (_config >> "sealTravel"),
    getNumber (_config >> "loadFilter"),
    getNumber (_config >> "crossTube"),
    getNumber (_config >> "tyreStiffness"),
    getNumber (_config >> "rollingFriction"),
    getNumber (_config >> "brakeFriction"),
    getNumber (_config >> "sideFriction"),
    getNumber (_config >> "slideRatio"),
    getNumber (_config >> "casualSideFriction"),
    getNumber (_config >> "casualSlideRatio"),
    getNumber (_config >> "casterFriction")
]];
_heli setVariable ["fza_ah64_suspFrame",   -1];
_heli setVariable ["fza_ah64_suspPrevArm", _wheels apply {[]}];
_heli setVariable ["fza_ah64_suspAnchors", _wheels apply {[]}];
_heli setVariable ["fza_ah64_suspStruts",  _wheels apply {[]}];
