maxOmega			= 2000;
numberPhysicalWheels = 3;
class Wheels
{
    class LF
    {
        steering                    = false;
        side                        = "left";
        boneName                    = "gear_left_wheel";
        suspForceAppPointOffset     = "gear_left_axis";
        tireForceAppPointOffset     = "gear_left_axis";
        center                      = "gear_left_axis";
        boundary                    = "gear_left_radius";
        suspTravelDirection[]       = {0, -1, -1};
        width                       = 0.40;
        mass                        = 30;
        MOI                         = 0.38;		// radius 0.38m

        dampingRate                 = 0;
        dampingRateDamaged          = 0;
        dampingRateDestroyed        = 0;

        maxBrakeTorque              = 2000;
        maxHandBrakeTorque          = 2000;

        maxCompression              = 0.23;
        maxDroop                    = 0.0;

        sprungMass                  = 3400;
        springStrength              = 12000;
        springDamperRate            = 1280;

        longitudinalStiffnessPerUnitGravity	= 5000;
        latStiffX                   = 25;
        latStiffY                   = 180;
        frictionVsSlipGraph[]       = {{0, 1}, {0.5, 1}, {1,1}};

        brakeIdleSpeed              = 3;
        class complexGearbox
        {
            GearboxRatios[] = {"N",0};
            TransmissionRatios[] = {"High",4.111}; // Optional: defines transmission ratios (for example, High and Low range as commonly found in offroad vehicles)
            moveOffGear			= 0; // defines what gear an automatic or semi-automatic gearbox will move off from stationary in. 1 by default.
            driveString			= "N"; // string to display in the HUD for forward gears.
            neutralString		= "N"; // string to display in the HUD for neutral gear.
            reverseString		= "N"; // string to display in the HUD for reverse gears.
        };
    };
    class LR: LF
    {
        boneName                = "gear_right_wheel";
        center                  = "gear_right_axis";
        boundary                = "gear_right_radius";
        suspForceAppPointOffset = "gear_right_axis";
        tireForceAppPointOffset = "gear_right_axis";
        side                    = "right";
    };
    class RF: LF
    {
        boneName                = "gear_tail_wheel";
        center                  = "gear_tail_axis";
        boundary                = "gear_tail_radius";
        suspForceAppPointOffset = "gear_tail_axis";
        tireForceAppPointOffset = "gear_tail_axis";
        steering                = true;
        side                    = "right";

        suspTravelDirection[]   = {0, -1, -0.65};
        width                   = 0.12;
        maxCompression          = 0.2;
        maxDroop                = 0.1;

        sprungMass              = 100;
        springStrength          = 15800;
        springDamperRate        = 5120;
	};
};