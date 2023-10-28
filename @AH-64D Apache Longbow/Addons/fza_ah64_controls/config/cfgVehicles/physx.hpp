numberPhysicalWheels = 3;
driveOnComponent[]	= {wheels};
class Wheels
{
    disableWheelsWhenDestroyed = 1;
    class LF
    {
        steering                    = false;
        side                        = "left";
        boneName                    = "gear_left_wheel";
        suspForceAppPointOffset     = "gear_left_axis";
        tireForceAppPointOffset     = "gear_left_axis";
        center                      = "gear_left_axis";
        boundary                    = "gear_left_radius";
        suspTravelDirection[]       = {0, -1, 0};
        width                       = 0.40;
        mass                        = 30;
        MOI                         = 0.38;		// radius 0.38m

        dampingRate                 = 0.1;
        dampingRateDamaged          = 0;
        dampingRateDestroyed        = 0;

        maxBrakeTorque              = 0;
        maxHandBrakeTorque          = 0;

        maxCompression              = 0.2;
        maxDroop                    = 0;

        sprungMass                  = 3400;
        springStrength              = 3000;
        springDamperRate            = 1280;

        longitudinalStiffnessPerUnitGravity	= 0;
        latStiffX                   = 0;
        latStiffY                   = 0;
        frictionVsSlipGraph[]       = {{0, 1}, {0.5, 1}, {1,1}};

        brakeIdleSpeed              = 3;
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