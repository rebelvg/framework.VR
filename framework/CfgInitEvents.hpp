class Extended_Init_EventHandlers
{
	class CAManBase
	{
		unitInit = "_this execVM 'framework\initEvents\unitInit.sqf'";
	};
	
	class Car
	{
		carInit = "_this execVM 'framework\initEvents\vehicleInit.sqf'";
	};
	class Tank
	{
		tankInit = "_this execVM 'framework\initEvents\vehicleInit.sqf'";
	};
	class Air
	{
		airInit = "_this execVM 'framework\initEvents\vehicleInit.sqf'";
	};
	class Ship
	{
		shipInit = "_this execVM 'framework\initEvents\vehicleInit.sqf'";
	};
	
	class ReammoBox_F
	{
		boxInit = "_this execVM 'framework\initEvents\boxInit.sqf'";
	};
};
