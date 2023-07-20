class Sounds
{
        class EngineExt
        {
            sound[] = {"\fza_ah64_US\audio\Engine", 1, 1.000000, 1200};
            frequency = "rotorSpeed";
            volume = "camPos*((rotorSpeed-0.72)*4)";
        };
        class RotorExt
        {
            sound[] = {"\fza_ah64_US\audio\Ext_Rotor.ogg", 1, 1.000000, 1200};
            frequency = "rotorSpeed * (1 - rotorThrust/5)";
            volume = "camPos*(0 max (rotorSpeed-0.1))*(1 + rotorThrust)";
        };
        class EngineClose
        {
            sound[] = {"\fza_ah64_US\audio\Engine_Close.ogg", 1, 1.000000, 1200};
            frequency = "rotorSpeed";
            volume = "camPos*((rotorSpeed-0.72)*4)";
        };
        class RotorClose
        {
            sound[] = {"\fza_ah64_US\audio\Rotor_Close.ogg", 1, 1.000000, 1200};
            frequency = "rotorSpeed * (1 - rotorThrust/5)";
            volume = "camPos*(0 max (rotorSpeed-0.1))*(1 + rotorThrust)";
        };
        class RotorSwist
        {
            sound[] = {"A3\Sounds_F\vehicles\air\Heli_Attack_01\swist", 0.500000, 1, 300};
            frequency = 1;
            volume = "camPos * (rotorThrust factor [0.7, 0.9])";
        };
        class TailRotor
        {
            cone[] = {3, 1.57, 3, 1.57};
            frequency = "rotorSpeed";
            sound[] = {"\fza_ah64_US\audio\Ext_Tail_Rotor.ogg", 3, 1, 1200};
            volume = "camPos*(0 max (rotorSpeed-0.1))*(1 + rotorThrust)";
        };
        class Distance
        {
            sound[]  = {"\fza_ah64_US\audio\Engine_Far.ogg", 4, 1, 3500};
            frequency = "rotorSpeed";
            volume = "2 * camPos * (0 max (rotorSpeed-0.4))";
        };
        class FarDistance
        {
            sound[]  = {"\fza_ah64_US\audio\Rotor_Far.ogg", 4, 1, 3500};
            frequency = "rotorSpeed";
            volume = "2 * camPos * (0 max (rotorSpeed-0.4))";
        };
        class EngineInt
        {
            sound[] = {"\fza_ah64_us\audio\Int_Engine.ogg", 1, 1.000000};
            frequency = "rotorSpeed";
            volume = "(1-camPos)*((rotorSpeed-0.75)*4)";
        };
        class RotorInt
        {
            sound[] = {"\fza_ah64_us\audio\Int_Rotor.ogg", 1, 1};
            frequency = "rotorSpeed * (1 - rotorThrust/5)";
            volume = "(1-camPos)*(0 max (rotorSpeed-0.1))*(1 + rotorThrust)";
        };
        class TransmissionDamageExt_phase1
        {
            sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_ext_1", 1.000000, 1.000000, 150};
            frequency = "0.66 + rotorSpeed / 3";
            volume = "camPos * (transmissionDamage factor [0.3, 0.35]) * (transmissionDamage factor [0.5, 0.45]) * (rotorSpeed factor [0.2, 0.5])";
        };
        class TransmissionDamageExt_phase2
        {
            sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_ext_2", 1.000000, 1.000000, 150};
            frequency = "0.66 + rotorSpeed / 3";
            volume = "camPos * (transmissionDamage factor [0.45, 0.5]) * (rotorSpeed factor [0.2, 0.5])";
        };
        class TransmissionDamageInt_phase1
        {
            sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_int_1", 1.000000, 1.000000, 150};
            frequency = "0.66 + rotorSpeed / 3";
            volume = "(1 - camPos) * (transmissionDamage factor [0.3, 0.35]) * (transmissionDamage factor [0.5, 0.45]) * (rotorSpeed factor [0.2, 0.5])";
        };
        class TransmissionDamageInt_phase2
        {
            sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_int_2", 1.000000, 1.000000, 150};
            frequency = "0.66 + rotorSpeed / 3";
            volume = "(1 - camPos) * (transmissionDamage factor [0.45, 0.5]) * (rotorSpeed factor [0.2, 0.5])";
        };
        class RainExt
        {
            sound[] = {"\fza_ah64_us\audio\Ext_Rain.ogg", 1.000000, 1.000000, 100};
            frequency = 1;
            volume = "((rain*abs(rotorspeed-1)) * 15) * camPos";
        };
        class RainInt
        {
            sound[] = {"\fza_ah64_us\audio\Int_Rain.ogg", 1.000000, 1.000000, 100};
            frequency = 1;
            volume = "((rain*(abs(rotorspeed-1)) * 7) * abs(camPos - 1)";
        };
        class WindInt
        {
            sound[] = {"A3\Sounds_F\vehicles\air\noises\wind_closed", 0.398107, 1.000000, 50};
            frequency = 1;
            volume = "(1-camPos)*(speed factor[5, 50])*(speed factor[5, 50])";
        };
        class GStress
        {
            sound[] = {"A3\Sounds_F\vehicles\noises\vehicle_stress2b", 0.354813, 1.000000, 50};
            frequency = 1;
            volume = "engineOn * (1-camPos) * ((gmeterZ factor[1.5, 2.5]) + (gmeterZ factor[0.5, -0.5]))";
        };
        class ETL_VRS_Shake_01
        {
            sound[]   = {"\fza_ah64_us\audio\CreakingAirFrame.ogg", 1, 1};
            frequency = "CustomSoundController3";
            volume    = "(1-camPos)*rotorSpeed*CustomSoundController4";
        };
        class ETL_VRS_Shake_02
        {
            sound[]   = {"A3\Sounds_F\vehicles\noises\vehicle_stress3", 1, 1};
            frequency = "CustomSoundController3";
            volume    = "(1-camPos)*rotorSpeed*CustomSoundController4";
        };
};