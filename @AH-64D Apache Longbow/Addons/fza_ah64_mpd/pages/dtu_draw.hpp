class dtu_draw {
    class outlines {
        type = line;
        width = 3;
        points[] = {
            //Curved box
            MPD_POINTS_BOX(Null, (0.5 - MPD_TEXT_WIDTH * 4), 0.12, (8 * MPD_TEXT_WIDTH), MPD_TEXT_HEIGHT)
        };
    };

    class barriers {
        color[] = {0.05,0.25,0,0.5};
        class Polygons {
            type = polygon;
            points[] = {
                { //Bottom
                    { {MPD_POS_BUTTON_TB_5_X-1.5*MPD_TEXT_WIDTH - MPD_BOX_PAD_X, MPD_POS_BUTTON_B_Y + MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_TB_5_X+1.5*MPD_TEXT_WIDTH + MPD_BOX_PAD_X, MPD_POS_BUTTON_B_Y + MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_TB_5_X+1.5*MPD_TEXT_WIDTH + MPD_BOX_PAD_X, MPD_POS_BUTTON_B_Y + 1.2*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_TB_5_X-1.5*MPD_TEXT_WIDTH - MPD_BOX_PAD_X, MPD_POS_BUTTON_B_Y + 1.2*MPD_TEXT_HEIGHT}, 1 },
                },
                {
                    { {MPD_POS_BUTTON_TB_6_X-1.5*MPD_TEXT_WIDTH - MPD_BOX_PAD_X, MPD_POS_BUTTON_B_Y + MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_TB_6_X+1.5*MPD_TEXT_WIDTH + MPD_BOX_PAD_X, MPD_POS_BUTTON_B_Y + MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_TB_6_X+1.5*MPD_TEXT_WIDTH + MPD_BOX_PAD_X, MPD_POS_BUTTON_B_Y + 1.2*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_TB_6_X-1.5*MPD_TEXT_WIDTH - MPD_BOX_PAD_X, MPD_POS_BUTTON_B_Y + 1.2*MPD_TEXT_HEIGHT}, 1 },
                },
                { //Top
                    { {MPD_POS_BUTTON_TB_6_X-1.5*MPD_TEXT_WIDTH - MPD_BOX_PAD_X, MPD_POS_BUTTON_T_Y}, 1 },
                    { {MPD_POS_BUTTON_TB_6_X+1.5*MPD_TEXT_WIDTH + MPD_BOX_PAD_X, MPD_POS_BUTTON_T_Y}, 1 },
                    { {MPD_POS_BUTTON_TB_6_X+1.5*MPD_TEXT_WIDTH + MPD_BOX_PAD_X, MPD_POS_BUTTON_T_Y - 0.2*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_TB_6_X-1.5*MPD_TEXT_WIDTH - MPD_BOX_PAD_X, MPD_POS_BUTTON_T_Y - 0.2*MPD_TEXT_HEIGHT}, 1 },
                },
                { //Left Side
                    { {MPD_POS_BUTTON_L_X - 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_6_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_L_X - 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_6_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_L_X - 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_6_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_L_X - 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_6_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                },
                {
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_1_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_1_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_1_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_1_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                },
                {
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_2_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_2_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_2_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_2_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                },
                {
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_3_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_3_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_3_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_3_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                },
                {
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_4_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_4_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_4_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_4_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                },
                {
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_5_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_5_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_5_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_5_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                },
                { //Right Side
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_6_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.4*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_6_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_6_Y + 1.25*MPD_TEXT_HEIGHT}, 1 },
                    { {MPD_POS_BUTTON_R_X + 0.2*MPD_TEXT_HEIGHT, MPD_POS_BUTTON_LR_6_Y - 0.25*MPD_TEXT_HEIGHT}, 1 },
                }                                                     
            };
        };
    };
    
    MPD_TEXT_C(DATE, 0.5, 0.12, MPD_TEXT_STATIC("MM/DD/YY"))
    
    class vabs {
        //T1
        MPD_BOX_TALL_C(DTU, MPD_POS_BUTTON_TB_1_X, MPD_POS_BUTTON_T_Y, 3)
        MPD_ARROW_C(DTU, MPD_POS_BUTTON_TB_1_X, MPD_POS_BUTTON_T_Y, 3)
        MPD_TEXT_C(DTU,  MPD_POS_BUTTON_TB_1_X, MPD_POS_BUTTON_T_Y, MPD_TEXT_STATIC("DTU"))
        //T6
        MPD_TEXT_C(DP,  MPD_POS_BUTTON_TB_6_X, MPD_POS_BUTTON_T_Y, MPD_TEXT_STATIC("DP"))

        //R1
        MPD_TEXT_L(EMER, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_1_Y, MPD_TEXT_STATIC("EMERG PROC"))
        //R2
        MPD_TEXT_L(THRU, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_2_Y, MPD_TEXT_STATIC("THRU-FLT"))
        //R3
        MPD_TEXT_L(SHOT, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_3_Y, MPD_TEXT_STATIC("SHOT AT"))
        //R4
        MPD_TEXT_L(MISC, MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_4_Y, MPD_TEXT_STATIC("MISCELLANEOUS"))
        //R5
        MPD_TEXT_L(FCR,  MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_5_Y, MPD_TEXT_STATIC("FCR LETHAL RANGES"))
        //R6
        MPD_TEXT_L(NAV,  MPD_POS_BUTTON_R_X, MPD_POS_BUTTON_LR_6_Y, MPD_TEXT_STATIC("NAVIGATION"))
        
        //B1
        MPD_TEXT_C(DMS,  MPD_POS_BUTTON_TB_1_X, MPD_POS_BUTTON_B_Y, MPD_TEXT_STATIC("DMS"))
        
        //B5
        //MPD_BAR_BOX_B(WP, MPD_POS_BUTTON_TB_5_X, MPD_POS_BUTTON_B_Y, 2)
        MPD_TEXT_C(WP,    MPD_POS_BUTTON_TB_5_X, MPD_POS_BUTTON_B_Y, MPD_TEXT_STATIC("WP"))
        //B6
        //MPD_BAR_BOX_B(SP, MPD_POS_BUTTON_TB_6_X, MPD_POS_BUTTON_B_Y, 2)
        MPD_TEXT_C(SP,  MPD_POS_BUTTON_TB_6_X, MPD_POS_BUTTON_B_Y, MPD_TEXT_STATIC("SP"))

        //L1
        MPD_TEXT_R(LOAD,       MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_1_Y, MPD_TEXT_STATIC("MASTER LOAD"))
        //L2
        MPD_TEXT_R(DATA_Label, MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_2_Y - 0.5 * MPD_TEXT_HEIGHT, MPD_TEXT_STATIC("DATA"))
        MPD_BOX_R(DATA,        MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_2_Y + 0.5 * MPD_TEXT_HEIGHT, 15)
        MPD_TEXT_R(DATA,       MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_2_Y + 0.5 * MPD_TEXT_HEIGHT, MPD_TEXT_STATIC("CURRENT MISSION"))
        //L6
        MPD_TEXT_R(WPNSGT,     MPD_POS_BUTTON_L_X, MPD_POS_BUTTON_LR_6_Y, MPD_TEXT_STATIC("WEAPONS/SIGHTS"))
    };
};