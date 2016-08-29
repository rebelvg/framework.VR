if (!isMultiplayer) then {
	[] call mf_disableAI_fnc;
	[] spawn mf_debugLoadout_fnc;
	
	DAC_Com_Values = [1,2,3,1];
	DAC_Marker = 2;
};

if (isNil "murshun_ffArray") then {
	murshun_ffArray = [];
};

if (isNil "murshun_respawnArray") then {
	murshun_respawnArray = [];
};

murshun_debriefing_text = "";

addMissionEventHandler ["Ended", {
	murshun_debriefing_text = format [
	"---Friendly Fire Logs---<br/>
	%1<br/>
	---Spectators---<br/>
	%2<br/>
	---Players---<br/>
	%3<br/>
	---Players Killed---<br/>
	%4<br/>
	---AI Killed---<br/>
	%5
	",
	str (murshun_ffArray apply {(_x select 1) + " damaged " + (_x select 0) + " " + str ceil ((time - (_x select 2))/60) + " minutes ago"}),
	str murshun_respawnArray,
	str (allPlayers apply {name _x}),
	murshun_framework_playersKilled,
	murshun_framework_unitsKilled
	];
}];

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	[false, true] call acre_api_fnc_setupMission;
	[true] call acre_api_fnc_setRevealToAI;
	[0] call acre_api_fnc_setLossModelScale;
	[false] call acre_api_fnc_setFullDuplex;
};

[] spawn {
	if (!hasInterface) exitWith {};

	waitUntil {!isNull player};
	
	if (!isMultiplayer) exitWith {};
	
	if (isNil "mf_onlyPilotsCanFly") exitWith {};
	
	if (!mf_onlyPilotsCanFly) exitWith {};

	player addEventHandler ["GetInMan", {
		params ["_unit", "_position", "_veh"];
		_className = tolower gettext (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
		
		if (_className == "pilot") exitWith {};
		
		if (!([_unit] call mf_fnc_isUnitPilot)) exitWith {};
		
		if ((getPosATL _veh) select 2 > 5) exitWith {};

		unassignVehicle _unit;
		moveOut _unit;
		
		systemChat "Only pilots can fly.";
	}];
	
	player addEventHandler ["SeatSwitchedMan", {
		params ["_unit", "_unit2", "_veh"];
		_className = tolower gettext (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
		
		if (_className == "pilot") exitWith {};
		
		if (!([_unit] call mf_fnc_isUnitPilot)) exitWith {};
		
		if ((getPosATL _veh) select 2 > 5) exitWith {};

		unassignVehicle _unit;
		moveOut _unit;
		
		systemChat "Can change sits only when flying.";
	}];
};

[] spawn {
	if (!hasInterface) exitWith {};
	
	waitUntil {!isNull player};

	if (isNil "base_marker") then {
		createMarkerLocal ["base_marker", getPos player];
	};

	if (isNil "respawn") then {
		createMarkerLocal ["respawn", getMarkerPos "base_marker"];
	};
};
