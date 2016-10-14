class Extended_Init_EventHandlers
{
	class CAManBase
	{
		unitInit = "_this execVM 'framework\initEvents\unitInit.sqf'";
	};
	
	class Car
	{
		carInit = "_this execVM 'framework\initEvents\vehicleInit.sqf'";
		radioInit = "_this execVM 'musicRadio\radioInit.sqf'";
	};
	class Tank
	{
		tankInit = "_this execVM 'framework\initEvents\vehicleInit.sqf'";
		radioInit = "_this execVM 'musicRadio\radioInit.sqf'";
	};
	class Air
	{
		airInit = "_this execVM 'framework\initEvents\vehicleInit.sqf'";
		radioInit = "_this execVM 'musicRadio\radioInit.sqf'";
	};
	class Ship
	{
		shipInit = "_this execVM 'framework\initEvents\vehicleInit.sqf'";
		radioInit = "_this execVM 'musicRadio\radioInit.sqf'";
	};
	
	class ReammoBox_F
	{
		boxInit = "_this execVM 'framework\initEvents\boxInit.sqf'";
	};
};
