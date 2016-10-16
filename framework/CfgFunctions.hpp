class CfgFunctions
{
	class MF
	{
		class functions
		{
			file = "framework\functions";
			
			class frameworkInit {preInit = 1;};
			class giveLoadout {};
			class fillBox {};
			class fillBoxMedical {};
			class onlyPilotsCanFlyPlayer {};
			class onlyPilotsCanFlyVehicle {};
		};
		
		class ai
		{
			file = "framework\ai";
			
			class spawnerInit {preInit = 1;};
		};
		
		class initEvents
		{
			file = "framework\initEvents";
			
			class unitInit {};
			class vehicleInit {};
			class boxInit {};
		};
		
		class loadouts
		{
			file = "mission\loadouts";
			
			class loadoutWest {};
			class loadoutEast {};
			class loadoutGuer {};
			class loadoutCiv {};
		};
		
		class mission
		{
			file = "mission";
			
			class settings {preInit = 1;};
		};
	};
};
