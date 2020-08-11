if (!(isNil "fza_ah64_nofcr")) exitwith {};
_heli = _this select 0;
_targets = [];
_curterhdg = 0;
_maxalt = 2;
_hdgblocked = 0;
_targlist = [];
_detectchance = 0.00834;
_adaunit = false;
_targetm = [];

if (isNil "fza_ah64_ada_units") then {
    fza_ah64_ada_units = ["O_APC_Tracked_02_AA_F", "O_T_APC_Tracked_02_AA_ghex_F", "rhs_zsutank_base", "LOP_ZSU234_base"];
};

while {
    (time > -1)
}
do {
    waituntil {
        (vehicle player) iskindof "fza_ah64base"
    };
    //_heli = vehicle player;
    waitUntil {
        ((driver(vehicle player) == player || gunner(vehicle player) == player) && isengineon(vehicle player))
    };
    if (fza_ah64_agmode == 1) then {
        _maxalt = 100;
    };
    if (fza_ah64_agmode == 0 || fza_ah64_agmode > 1) then {
        _maxalt = 2;
    };
    if (fza_ah64_fcrstate == 1 && (typeOf _heli == "fza_ah64d_b2e") && !("fza_ah64_fcr_fail" in (_heli magazinesturret[-1]))) then {
        //add targets to master list
        //_targets = (list _radsweep);
        //_targets = vehicles - allDead;

        _targetm = listRemoteTargets west;

        {
            _targets pushback(_x select 0);
        }
        foreach _targetm;


        {
            if (alive _x && !(_x in fza_ah64_targetlist)) then {
                _rem = false;
                _i = _x;
                _adaunit = false; {
                    if (_i iskindof _x) then {
                        _adaunit = true;
                    };
                }
                foreach fza_ah64_ada_units;

                //_theta = [_heli,(getposatl _heli select 0),(getposatl _heli select 1),(getposatl _i select 0),(getposatl _i select 1)] call fza_ah64_reldir;

                if (_i distance _heli > 10000 || (_i iskindof "man") || !(alive _i)) then {
                    _targets = _targets - [_i];
                    _rem = true;
                };
                if ((fza_ah64_agmode == 0 || fza_ah64_agmode > 1) && (getpos _i select 2 >= 10)) then {
                    _targets = _targets - [_i];
                    _rem = true;
                };
                if (fza_ah64_agmode == 1 && ((getpos _i select 2) < 10)) then {
                    _targets = _targets - [_i];
                    _rem = true;
                };
                if (!(_i isKindOf "helicopter" || _i isKindOf "plane" || _i isKindOf "car" || _i isKindOf "tank" || _i isKindOf "ship" || _i isKindOf "StaticCannon" || _adaunit)) then {
                    _targets = _targets - [_i];
                    _rem = true;
                };

                if (!(_rem)) then {
                    _randchance = random 100;
                    _detectchance = 0.00050;

                    if (_adaunit) then {
                        _detectchance = 0.00017;
                    };
                    if (((_i distance _heli) * _detectchance) > _randchance) then {
                        _targets = _targets - [_i];
                    };
                    //if((terrainIntersectasl [getposasl _heli, [(getPosASL _i select 0),(getPosASL _i select 1),(getPosASL _i select 2)+1]]) || (lineIntersects [getposasl _heli, getPosASL _i, _heli, _i])) then {_targets = _targets - [_i];};
                };
                sleep 0.03;
            };
        }
        foreach _targets;


        {
            if (!(_x in fza_ah64_targetlist)) then {
                fza_ah64_targetlist = fza_ah64_targetlist + [_x];
                _heli reveal _x;
            };
        }
        foreach _targets; {
            if (!(_x in fza_ah64_fcrlist)) then {
                fza_ah64_fcrlist = fza_ah64_fcrlist + [_x];
            };
        }
        foreach _targets;
    };
    sleep 2;
};