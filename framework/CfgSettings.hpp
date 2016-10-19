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
		
		class scripts
		{
			file = "framework\scripts";
			
			class frameworkBriefing {};
			class acreSettings {};
			class radioBriefing {};
			class teamRoster {};
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
			class frameworkSettings {
				preInit = 1;
				file = "mission\fn_settings.sqf";
			};
			class spawnerSettings {
				preInit = 1;
				file = "mission\ai\fn_units.sqf";
			};
		};
	};
};

class Extended_InitPost_EventHandlers
{
	class CAManBase
	{
		unitInit = "_this call mf_fnc_unitInit";
	};
	
	class Car
	{
		carInit = "_this call mf_fnc_vehicleInit";
	};
	class Tank
	{
		tankInit = "_this call mf_fnc_vehicleInit";
	};
	class Air
	{
		airInit = "_this call mf_fnc_vehicleInit";
	};
	class Ship
	{
		shipInit = "_this call mf_fnc_vehicleInit";
	};
	
	class ReammoBox_F
	{
		boxInit = "_this call mf_fnc_boxInit";
	};
};

class CfgTaskEnhancements
{
	enable = 1;
	3d = 0;
	3dDrawDist = 0;
	share = 0;
	propagate = 0;
};

class CfgDebriefing
{
	class Completed1
	{
		title = "Mission Completed!";
		subtitle = "Good Job!";
		description = "";
	};
	class Failed1
	{
		title = "Mission Failed!";
		subtitle = "Come on, guys.";
		description = "";
	};	
};

class CfgDebriefingSections
{
	class PrintMurshunDebriefing
	{
		title = "Murshun Debriefing Screen";
		variable = "mf_debriefingText";
	};
};
