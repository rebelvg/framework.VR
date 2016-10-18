//https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul

//creates task, waits until the unit is 50m from the marker, completes task
//can be unit or object

[WEST, "task_id", ["Task description.", "Rescue"], unit, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
	unit distance getMarkerPos "marker" < 50
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until objects are not alive
//can be anything, units, vehicles, boxes

[WEST, "task_id", ["Task description.", "Search And Destroy"], nil, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

_objArray = [obj_01, obj_02, obj_03];

waitUntil {
	{alive _x} count _objArray == 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until at least one player is 50m from the marker

[WEST, "task_id", ["Task description.", "Visit Position"], "marker", "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
	{_x distance getMarkerPos "marker" < 50} count allPlayers > 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until more than 80% of players (not spectators) are 50m from the marker

[WEST, "task_id", ["Task description.", "Visit Position (Group)"], "marker", "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

_marker = "marker";
_radius = 50;

waitUntil {
	{_x distance getMarkerPos _marker < _radius} count allPlayers >= ({!isObjectHidden _x} count allPlayers) * 0.8 && {_x distance getMarkerPos _marker < _radius} count allPlayers > 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//this block will spawn a thread that will end a mission if everyone is dead (aka spectating)

[] spawn {
	waitUntil {
		{isObjectHidden _x} count allPlayers == count allPlayers && count allPlayers > 0
	};

	_string = format ["Mission failed. Mission will end in 15 seconds."];
	[_string, "systemChat"] call BIS_fnc_MP;

	sleep 15;

	[{
		["Failed1", false, true, true] call BIS_fnc_endMission;
	}, "BIS_fnc_spawn"] call BIS_fnc_MP;
};

//waits until there's no east side units in the 500m radius of the marker
//checks if at least one of the players is around too (to prevent auto-completion if using dac or alive or other dynamic ai systems)

[WEST, "task_id", ["Task description.", "Clear Area"], "marker", "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

_marker = "marker";
_radius = 500;
_enemySide = EAST;

waitUntil {
	{side _x == _enemySide && _x distance2d getMarkerPos _marker < _radius} count allUnits == 0 && {_x distance2d getMarkerPos _marker < _radius} count allPlayers > 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until there's more players in the 500m radius of the marker than east side units
//task already implies that players should be in the area

[WEST, "task_id", ["Task description.", "Overrun Area"], "marker", "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

_marker = "marker";
_radius = 500;
_enemySide = EAST;

waitUntil {
	{_x distance2d getMarkerPos _marker < _radius} count allPlayers > {side _x == _enemySide && _x distance2d getMarkerPos _marker < _radius} count allUnits
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//this block creates two simultaneous tasks that run at the same time
//simple tvt tasks
//eliminate enemy team, west vs east
//reason why this doesn't use allPlayers is because it will auto-complete in the editor/single-player
//also waits for mission to actually start to prevent auto-completion when players are still loading in the lobby

[] spawn {
	[WEST, "west_task_id", ["Task description.", "Eliminate East Side Team"], nil, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;
	
	waitUntil {
		{side _x == EAST && !isObjectHidden _x} count (playableUnits + switchableUnits) == 0 && time > 0
	};
	
	["west_task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;
};

[] spawn {
	[EAST, "east_task_id", ["Task description.", "Eliminate West Side Team"], nil, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;
	
	waitUntil {
		{side _x == WEST && !isObjectHidden _x} count (playableUnits + switchableUnits) == 0 && time > 0
	};
	
	["east_task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;
};

//call mission completed

[{
	["Completed1", true, true, true] call BIS_fnc_endMission;
}, "BIS_fnc_spawn"] call BIS_fnc_MP;

//call mission failed

[{
	["Failed1", false, true, true] call BIS_fnc_endMission;
}, "BIS_fnc_spawn"] call BIS_fnc_MP;
