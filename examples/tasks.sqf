//https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul

/*
//creates task, waits until the hostage is 50m from the base marker, completes task
//hostage must be an object in the editor

[BluFor, "blufor_hostage_task", ["Task description.", "Hostage Rescue"], hostage, "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	hostage distance getMarkerPos "base_marker" < 50
};

["blufor_hostage_task", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//waits until objects are not alive
//can be anything, units, vehicles, boxes

_objArray = [obj_01, obj_02, obj_03];

[BluFor, "blufor_sad_task", ["Task description.", "Search And Destroy"], nil, "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	{alive _x} count _objArray == 0
};

["blufor_sad_task", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//waits until at least one player is 50m from the position marker

[BluFor, "blufor_visit_pos_task", ["Task description.", "Visit Position"], "position_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	{_x distance getMarkerPos "position_marker" < 50} count allPlayers > 0
};

["blufor_visit_pos_task", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//waits until more than 80% of players (not spectators) are 50m from the base marker

[BluFor, "blufor_rtb_task", ["Task description.", "RTB"], "base_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	{_x distance getMarkerPos "base_marker" < 50} count allPlayers > ({!isObjectHidden _x} count allPlayers) * 0.8
};

["blufor_rtb_task", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//this block will spawn a thread that will end a mission if everyone is dead (aka spectating)

[] spawn {
	waitUntil {
		{isObjectHidden _x} count allPlayers == count allPlayers && count allPlayers > 0
	};
	
	[{
		["Failed1", false, true, true] call BIS_fnc_endMission;
	},"BIS_fnc_spawn"] call BIS_fnc_MP;
};
*/

/*
//waits until there's no east side units in the 500m radius of the attack marker
//checks if at least one of the players is around too (to prevent auto-completion if using dac or alive or other dynamic ai spawn systems)

[BluFor, "blufor_clear_area_task", ["Task description.", "Clear Area"], "attack_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	{side _x == EAST && _x distance2d getMarkerPos "attack_marker" < 500} count allUnits == 0 && {_x distance2d getMarkerPos "attack_marker" < 500} count allPlayers > 0
};

["blufor_clear_area_task", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//waits until there's more players in the 500m area then east side units
//task already implies that players should be in the area

[BluFor, "blufor_overrun_area_task", ["Task description.", "Overrun Area"], "overrun_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	{_x distance2d getMarkerPos "overrun_marker" < 500} count allPlayers > {side _x == EAST && _x distance2d getMarkerPos "overrun_marker" < 500} count allUnits
};

["blufor_overrun_area_task", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//this block creates two simultaneous tasks that run at the same time
//simple tvt tasks
//eliminate enemy team, west vs east
//reason why this doesn't use allPlayers is because it will auto-complete in the editor/single-player
//also waits for mission to actually start to prevent auto-completion when players are still loading in the lobby
//this works because spectators are counted as civilians

[] spawn {
	[BluFor, "blufor_sad_east_task", ["Task description.", "Eliminate East Side Team"], nil, "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;
	
	waitUntil {
		{side _x == EAST} count (playableUnits + switchableUnits) == 0 && time > 0
	};
	
	["blufor_sad_east_task", "Succeeded", true] call BIS_fnc_taskSetState;
};

[] spawn {
	[OpFor, "opfor_sad_west_task", ["Task description.", "Eliminate West Side Team"], nil, "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;
	
	waitUntil {
		{side _x == WEST} count (playableUnits + switchableUnits) == 0 && time > 0
	};
	
	["opfor_sad_west_task", "Succeeded", true] call BIS_fnc_taskSetState;
};
*/

/*
//call mission completed

[{
	["Completed1", true, true, true] call BIS_fnc_endMission;
},"BIS_fnc_spawn"] call BIS_fnc_MP;
*/

/*
//call mission failed

[{
	["Failed1", false, true, true] call BIS_fnc_endMission;
},"BIS_fnc_spawn"] call BIS_fnc_MP;
*/
