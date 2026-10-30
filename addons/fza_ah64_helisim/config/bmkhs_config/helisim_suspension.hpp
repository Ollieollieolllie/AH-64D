/////////////////////////////////////////////////////////////////////////////////////////////
// Landing Gear /////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
    //Read by fza_ah64_helisim_fnc_suspensionVariables, not by Core. Positions are in the Arma
    //frame, not the model frame.
    class Suspension {
        designMass      = 9000;     //kg
        gasExponent     = 1.35;
        dampingRatio    = 0.6;
        dampingLimit    = 2.0;      //Damper blow off, as a multiple of static load
        sealFriction    = 0.05;     //Breakout force of the strut seals, of static load
        sealTravel      = 0.0005;   //m, the seals give this much before they slip
        loadFilter      = 0.5;      //s, how fast a strut's carried load follows its spring
        crossTube       = 130000;   //N/m, between the main gear trailing arms
        tyreStiffness   = 270000;   //N/m, at a load share of 1
        rollingFriction = 0.012;
        brakeFriction   = 0.5;
        sideFriction    = 0.3;
        slideRatio      = 0.5;      //Grip left once a tyre lets go
        casualSideFriction = 0.5;   //Casual's tyres can't roll it over, so they can grip harder
        casualSlideRatio   = 0.8;
        casterFriction  = 0.08;     //Side scrub of the swivelling tail wheel

        //position[] - tyre contact point at designMass
        //extension  - m, from there to the strut fully extended
        //travel     - m, fully extended to the hull meeting the ground
        //gasLength  - m, gas column at designMass. Shorter is stiffer
        //loadShare  - of the weight, at the design CG
        //brake      - held by the parking brake
        //The main gear comes first: the cross tube joins wheels 0 and 1.
        class Wheels {
            class MainRight {
                position[] = { 1.14, 3.13, -3.05};
                extension  = 0.272;
                travel     = 0.455;
                gasLength  = 0.25;
                loadShare  = 0.4425;
                brake      = 1;
            };
            class MainLeft: MainRight {
                position[] = {-1.14, 3.13, -3.05};
            };
            class Tail {
                position[] = { 0.00, -7.38, -3.00};
                extension  = 0.118;
                travel     = 0.271;
                gasLength  = 0.20;
                loadShare  = 0.115;
                brake      = 0;
            };
        };
    };
