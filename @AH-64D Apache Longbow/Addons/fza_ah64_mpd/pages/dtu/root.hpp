class dtu_draw {
    class outlines {
        type = line;
        width = 3;
        points[] = {
            //Curved box
            MPD_POINTS_BOX(Null, (0.5 - MPD_TEXT_WIDTH * 4), 0.12, (8 * MPD_TEXT_WIDTH), MPD_TEXT_HEIGHT)
        };
    };

    MPD_TEXT_C(DATE, 0.5, 0.12, MPD_TEXT_USER(MFD_TEXT_DTU_DATE))
    
    class vabs {
        //T1
        MPD_BOX_TALL_C(DTU, MPD_POS_BUTTON_TB_1_X, MPD_POS_BUTTON_T_Y, 3)
        MPD_ARROW_C(DTU, MPD_POS_BUTTON_TB_1_X, MPD_POS_BUTTON_T_Y, 3)
        MPD_TEXT_C(DTU,  MPD_POS_BUTTON_TB_1_X, MPD_POS_BUTTON_T_Y, MPD_TEXT_STATIC("DTU"))
        //T6
        MPD_BOX_BAR_T(DP, MPD_POS_BUTTON_TB_6_X, MPD_POS_BUTTON_T_Y);
        MPD_TEXT_C(DP,  MPD_POS_BUTTON_TB_6_X, MPD_POS_BUTTON_T_Y, MPD_TEXT_STATIC("DP"))

        //R1
        MPD_BOX_BAR_L(EMER, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_1_Y)
        MPD_TEXT_L(EMER,    MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_1_Y, MPD_TEXT_STATIC("EMERG PROC"))
        //R2
        MPD_BOX_BAR_L(THRU, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_2_Y)
        MPD_TEXT_L(THRU,    MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_2_Y, MPD_TEXT_STATIC("THRU-FLT"))
        //R3
        MPD_BOX_BAR_L(SHOT, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_3_Y)
        MPD_TEXT_L(SHOT,    MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_3_Y, MPD_TEXT_STATIC("SHOT AT"))
        //R4
        MPD_BOX_BAR_L(MISC, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_4_Y)
        MPD_TEXT_L(MISC,    MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_4_Y, MPD_TEXT_STATIC("MISCELLANEOUS"))
        //R5
        MPD_BOX_BAR_L(FCR, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_5_Y)
        MPD_TEXT_L(FCR,    MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_5_Y, MPD_TEXT_STATIC("FCR LETHAL RANGES"))
        //R6
        MPD_BOX_BAR_L(NAV, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_6_Y)
        MPD_TEXT_L(NAV,    MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_6_Y, MPD_TEXT_STATIC("NAVIGATION"))
        
        //B1
        MPD_TEXT_C(DMS,  MPD_POS_BUTTON_TB_1_X, MPD_POS_BUTTON_B_Y, MPD_TEXT_STATIC("DMS"))
        //B5
        MPD_BOX_BAR_B(WP, MPD_POS_BUTTON_TB_5_X, MPD_POS_BUTTON_B_Y)
        MPD_TEXT_C(WP,    MPD_POS_BUTTON_TB_5_X, MPD_POS_BUTTON_B_Y, MPD_TEXT_STATIC("WP"))
        //B6
        MPD_BOX_BAR_B(SP, MPD_POS_BUTTON_TB_6_X, MPD_POS_BUTTON_B_Y)
        MPD_TEXT_C(SP,    MPD_POS_BUTTON_TB_6_X, MPD_POS_BUTTON_B_Y, MPD_TEXT_STATIC("SP"))

        //L1
        MPD_TEXT_R(LOAD,       MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_1_Y, MPD_TEXT_STATIC("MASTER LOAD"))
        //L2
        MPD_TEXT_R(DATA_Label, MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_2_Y - 0.5 * MPD_TEXT_HEIGHT, MPD_TEXT_STATIC("DATA"))
        MPD_BOX_R(DATA,        MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_2_Y + 0.5 * MPD_TEXT_HEIGHT, 15)
        MPD_TEXT_R(DATA,       MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_2_Y + 0.5 * MPD_TEXT_HEIGHT, MPD_TEXT_STATIC("CURRENT MISSION"))
        //L6
        MPD_BOX_BAR_R(WPNSGT,  MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_6_Y)
        MPD_TEXT_R(WPNSGT,     MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_6_Y, MPD_TEXT_STATIC("WEAPONS/SIGHTS"))
    };
};