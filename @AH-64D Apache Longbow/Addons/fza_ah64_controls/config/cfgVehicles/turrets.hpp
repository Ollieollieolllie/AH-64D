class Turrets : Turrets
{
    class MainTurret: NewTurret
    {
        gunnerAction = "fza_ah64_copilot";
        gunnerGetInAction = "pilot_Heli_Light_02_Enter";
        gunnerGetOutAction = "GetOutHigh";
        preciseGetInOut = 1;
        hideWeaponsGunner = false;
        primary = 1;
        primaryGunner = 1;
        stabilizedInAxes = 3;
        weapons[] = {"fza_ma_safe", "fza_gun_safe", "Laserdesignator_mounted", "fza_burstlimiter","fza_m230"};
        magazines[] = {"fza_safe", "LaserBatteries", "fza_m230_300"};
        memoryPointsGetInGunner = "pos gunner";
        memoryPointsGetInGunnerDir = "pos gunner dir";
        memoryPointGun = "laserBegin";
        memoryPointGunnerOptics = "gunnerview";
        body = "tads_tur";
        gun = "tads";
        animationsourcebody = "tads_tur";
        animationsourcegun = "tads";
        gunBeg = "laserBegin";
        gunEnd = "laserEnd";
        gunnerOpticsModel = "";
        gunnerOpticsColor[] = {1,1,1,1};
        minElev = -60;
        maxElev = 30;
        initElev= 0;
        maxXRotSpeed = 1;	// yawing speed
        maxYRotSpeed = 1;	// pitching speed
        maxMouseXRotSpeed= 0.5;
        maxMouseYRotSpeed= 0.5;
        minTurn = -120;
        maxTurn = 120;
        initTurn = 0;
        minGunElev = -60;
        maxGunElev = 30;
        minGunTurn = -120;
        maxGunTurn = 120;
        minGunTurnAI = -90;
        maxGunTurnAI = 90;
        commanding = -1;
        gunnerForceOptics = 0;
        startEngine=0;
        outGunnerMayFire = 1;
        turretinfotype = "RscUnitInfoNoHUD";
        turretFollowFreeLook = 0;
        discreteDistance[]={100,200,300,400,500,600,700,800,1000,1200,1500,1800,2100,2500,2800,3300};
        discreteDistanceInitIndex=5;
        isCopilot = 1;
        usePiP=1;
        class Reflectors
        {
            class cabin
            {
                color[]={0.306, 0.878, 0.349};
                ambient[] = {0.306, 0.878, 0.349};
                intensity = 25;
                size = 1;
                innerAngle = 30;
                outerAngle = 150;
                coneFadeCoef = 1;
                position = "plt_floodlamps";
                direction = "plt_memflood";
                hitpoint = "plt_floodlamps";
                selection = "plt_floodlamps";
                useFlare = 0;
                flareSize = 0;
                flareMaxDistance = 0;
                dayLight = 1;
                blinking = 0;
                class Attenuation
                {
                    start           = 0;
                    constant        = 0;
                    linear          = 1;
                    quadratic       = 2;
                    hardLimitStart  = 0.65;
                    hardLimitEnd    = 1.9;
                };
            };
            class cargo_light_1: cabin
            {
                position = "cpg_flood";
                direction = "cpg_memflood";
                hitpoint = "cpg_flood";
                selection = "cpg_flood";
            };
        };
        class HitPoints
        {
            class HitTurret
            {
                armor = 0.9;
                material = 51;
                name = "tads_tur";
                visual = "skin_tads1";
                passThrough = 1;
            };
            class HitGun
            {
                armor = 1.3;
                material = 52;
                name = "otochlaven";
                visual = "skin_otochlaven";
                passThrough = 1;
            };
        };
        class OpticsIn
        {
            class Wide
            {
                gunneropticsmodel = "\fza_ah64_us\fza_ah64_optics_empty";
                directionStabilized = 1;
                initanglex = 0;
                initangley = 0;
                initfov = 0.466;
                maxanglex = 30;
                maxangley = 120;
                maxfov = 0.466;
                minanglex = -60;
                minangley = -120;
                minfov = 0.466;
                opticsdisplayname = "W";
                thermalmode[] = {0,1};
                visionmode[] = {"Normal","Ti"};
            };
            class Medium: Wide
            {
                gunneropticsmodel = "\fza_ah64_us\fza_ah64_optics_empty";
                initfov = 0.09;
                maxfov = 0.09;
                minfov = 0.09;
                opticsdisplayname = "M";
            };
            class Narrow: Wide
            {
                gunneropticsmodel = "\fza_ah64_us\fza_ah64_optics_empty";
                initfov = 0.01;
                maxfov = 0.01;
                minfov = 0.01;
                opticsdisplayname = "N";
            };
        };
        class OpticsOut
        {
            class Monocular //FOV CPG
            {
                gunneropticseffect[] = {};
                gunneropticsmodel = "";
                initfov = 0.7;
                initanglex = 0;
                initangley = 0;
                minfov = 0.4;
                maxfov = 0.7;
                minanglex = -60;
                maxanglex = 30;
                minangley = -120;
                maxangley = 120;
            };
        };
        class Components
        {
            class VehicleSystemsDisplayManagerComponentLeft
            {
                componentType = "VehicleSystemsDisplayManager";
                x = "(profilenamespace getvariable [""IGUI_GRID_CUSTOMINFOLEFT_X"",	(safezoneX + 0.5 * (((safezoneW / safezoneH) min 1.2) / 40))])";
                y = "(profilenamespace getvariable [""IGUI_GRID_CUSTOMINFOLEFT_Y"",	(safezoneY + safezoneH - 21 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])";
                left = 1;
                defaultDisplay = "CrewDisplay";
                class Components
                {
                    class EmptyDisplay		// Empty display - hide panel
                    {
                        componentType = "EmptyDisplayComponent";
                    };
                    class MinimapDisplay	// GPS
                    {
                        componentType = "MinimapDisplayComponent";
                        resource = "RscCustomInfoMiniMap";
                    };
                };
            };
            class VehicleSystemsDisplayManagerComponentRight : VehicleSystemsDisplayManagerComponentLeft {
                left = 0;
                right = 1;
                x = "(profilenamespace getvariable [""IGUI_GRID_CUSTOMINFORIGHT_X"",((safezoneX + safezoneW) - ((10 * (((safezoneW / safezoneH) min 1.2) / 40)) + 0.5 * (((safezoneW / safezoneH) min 1.2) / 40)))])";
                y = "(profilenamespace getvariable [""IGUI_GRID_CUSTOMINFORIGHT_Y"",(safezoneY + safezoneH - 21 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])";
            };
        };
        class MFD {};
    };
};