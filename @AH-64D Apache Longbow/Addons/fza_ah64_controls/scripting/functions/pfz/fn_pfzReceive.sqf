/* ----------------------------------------------------------------------------
Function: fza_fnc_pfzReceive

Description:
    Stores PFZ that was broadcasted by another helicopter in currently selected PFZ
    
Parameters:

Returns:
    Nothing
    
Examples:
    [_heli] spawn fza_fnc_pfzReceive;
    
Author:
---------------------------------------------------------------------------- */
params["_heli"];
if (fza_ah64_pfzcache select 1 == "all" || fza_ah64_pfzcache select 1 == (name player)) then {
    _pfzIndex = _heli getVariable "fza_ah64_pfz_count";
    if(1 <= _pfzIndex && _pfzIndex <= 8) then {
        _pfzs = _heli getVariable "fza_ah64_pfzs";
        _receivedData = (fza_ah64_pfzcache select 2);
        _pfzs set [_pfzIndex - 1, _receivedData];
        _heli setVariable ["fza_ah64_pfzs", _pfzs, true];
        _heli vehiclechat "PFZ Successfully loaded!";
    }
}