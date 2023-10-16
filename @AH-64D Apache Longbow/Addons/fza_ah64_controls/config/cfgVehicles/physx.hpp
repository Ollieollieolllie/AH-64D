maxOmega			= 2000;
numberPhysicalWheels = 3;
class Wheels
{
	class LF
	{
		steering					= false;
		side						= "left";
		boneName					= "l_wheel";
		suspForceAppPointOffset		= "osa_leftGear_axis";
		tireForceAppPointOffset		= "osa_leftGear_axis";
		center						= "osa_leftGear_axis";
		boundary					= "osa_Leftgear_bound";
		suspTravelDirection[]		= {0, -1, -1};
		width						= 0.16;
		mass						= 15;
		MOI							= 0.38;		// radius 0.38m

		dampingRate					= 0.1;
		dampingRateDamaged			= 1;
		dampingRateDestroyed		= 1000;

		maxBrakeTorque				= 2000;
		maxHandBrakeTorque			= 0;

		maxCompression				= 0.23;
		maxDroop					= 0.0;

		sprungMass					= 3400;
		springStrength				= 12000;
		springDamperRate			= 1280;

		longitudinalStiffnessPerUnitGravity	= 5000;
		latStiffX					= 2.5;
		latStiffY					= 18.0;
		frictionVsSlipGraph[]		= {{0, 1}, {0.5, 1}, {1,1}};

	};
	class LR: LF
	{
		boneName = "R_wheel";
		center   = "osa_RightGear_axis";
		boundary = "osa_RightGear_bound";
		suspForceAppPointOffset = "osa_RightGear_axis";
		tireForceAppPointOffset = "osa_RightGear_axis";
	};
	class RF: LF
	{
		boneName = "wheel";
		center   = "osa_tailwheel";
		boundary = "osa_tailwheel_bound";
		suspForceAppPointOffset = "osa_tailwheel";
		tireForceAppPointOffset = "osa_tailwheel";
		steering = true;
		side = "right";

		suspTravelDirection[]		= {0, -1, -0.65};
		width						= 0.12;
		maxCompression				= 0.2;
		maxDroop					= 0.1;

		sprungMass					= 100;
		springStrength				= 15800;
		springDamperRate			= 5120;
	};
};