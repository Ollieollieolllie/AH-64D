class cfgWeapons
{
	class InventoryItem_Base_F;
	class ItemCore;
    class NVGoggles;
    class fza_NVG: NVGoggles {
		scope = 1;
		displayName = "";
		model = "";
		picture = "";
		visionMode[] = {"Normal","NVG"};
		modelOptics = "";
    }
    class HeadgearItem: InventoryItem_Base_F
    {
        allowedSlots[] = {901, 605};
        type = 605;
        hiddenSelections[] = {};
        hitpointName = "HitHead";
    };
    
    class fza_ah64_Ihadss_helmet: ItemCore
    {
		author = "AH-64 Project";
        scope = 2;
        displayName  = "Ihadss Helmet";
        picture = "";
        model   = "fza_ah64_ihadss\model\fza_ah64_ihadss.p3d";
        hiddenSelections[] = {"camo"};
        hiddenSelectionsTextures[] = {"\a3\characters_f\common\data\capb_police_co.paa"};
        ace_hearing_protection = 0.80;
        ace_hearing_lowerVolume = 0.60;
        class ItemInfo: HeadgearItem
        {
            mass = 50;
            uniformModel = "fza_ah64_ihadss\model\fza_ah64_ihadss.p3d";
            allowedSlots[] = {901, 605};
            modelSides[] = {"TWest"};
            hiddenSelections[] = {"camo"};
            subItems[] = {"fza_NVG"};   
            class HitpointsProtectionInfo
            {
                class Head
                {
                    hitpointName	= "HitHead";
                    armor		= 6;
                    passThrough	= 0.5;
                };
            };
        };
    };
};