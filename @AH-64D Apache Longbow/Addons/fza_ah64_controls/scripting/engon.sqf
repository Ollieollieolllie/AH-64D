_heli = _this select 0;
_enginestate = _this select 1;

if(local _heli && player in _heli) then
{
if(_enginestate) then
{
sleep 0.1;
_heli animate ["plt_eng1_start",1];
_heli animate ["plt_eng1_throttle",0.25];
_heli animate ["tads_stow",0];
_heli animate ["plt_batt",1];
fza_ah64_estarted = true;

} else {
if(fza_ah64_cem) then
{
	fza_ah64_ihadssoff = 1;
	fza_ah64_monocleinbox = 1;
};
sleep 0.1;
_heli animate ["plt_eng1_start",0];
_heli animate ["plt_eng1_throttle",0];
_heli animate ["tads_stow",1];
_heli animate ["plt_batt",0];
fza_ah64_estarted = false;
};
};