//https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul

//creates task, waits until object is 50m from the marker, completes task
//can be anything, unit, vehicle, box

_obj = mission_unit;
_marker = "mission_marker";
_radius = 50;

[WEST, "task_id", ["Task description.", "Rescue"], _obj, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
    _obj distance getMarkerPos _marker < _radius
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until objects are not alive
//can be anything, units, vehicles, boxes

_objs = [mission_obj_01, mission_obj_02, mission_obj_03];

[WEST, "task_id", ["Task description.", "Search and Destroy"], nil, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
    {alive _x} count _objs == 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until at least one player on foot is 50m from the marker

_marker = "mission_marker";
_radius = 50;

[WEST, "task_id", ["Task description.", "Visit Position"], _marker, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
    {_x distance getMarkerPos _marker < _radius && vehicle _x == _x} count allPlayers > 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until more than 80% of players (not spectators) are 50m from the marker

_marker = "mission_marker";
_radius = 50;
_percent = 0.8;

[WEST, "task_id", ["Task description.", "Visit Position (Group)"], _marker, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
    {_x distance getMarkerPos _marker < _radius} count allPlayers >= ({!isObjectHidden _x} count allPlayers) * _percent && {_x distance getMarkerPos _marker < _radius} count allPlayers > 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until no players are 1km from the marker

_marker = "mission_marker";
_radius = 1000;

[WEST, "task_id", ["Task description.", "Leave Position"], _marker, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
    {_x distance getMarkerPos _marker < _radius} count allPlayers == 0 && {!isObjectHidden _x} count allPlayers > 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//this block will spawn a thread that will monitor mission failure if everyone is dead (aka spectating)

[] spawn {
    waitUntil {
        {isObjectHidden _x} count allPlayers == count allPlayers && count allPlayers > 0 && time > 0
    };

    "Mission failed." remoteExec ["systemChat"];
};

//waits until there's no east side units in the 500m radius of the marker
//checks if at least one of the players on foot is around too (to prevent auto-completion if using dac or alive or other dynamic ai systems)

_marker = "mission_marker";
_radius = 500;
_enemySide = EAST;

[WEST, "task_id", ["Task description.", "Clear Area"], _marker, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
    {side _x == _enemySide && _x distance2d getMarkerPos _marker < _radius} count allUnits == 0 && {_x distance2d getMarkerPos _marker < _radius && vehicle _x == _x} count allPlayers > 0
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//waits until there's more players on foot in the 500m radius of the marker than east side units
//task already implies that players should be in the area

_marker = "mission_marker";
_radius = 500;
_enemySide = EAST;

[WEST, "task_id", ["Task description.", "Overrun Area"], _marker, "ASSIGNED", 0, true, "default"] call BIS_fnc_taskCreate;

waitUntil {
    {_x distance2d getMarkerPos _marker < _radius && vehicle _x == _x} count allPlayers > {side _x == _enemySide && _x distance2d getMarkerPos _marker < _radius} count allUnits
};

["task_id", "SUCCEEDED", true] call BIS_fnc_taskSetState;

//this block will add ace action to the item

_obj = mission_obj;

_action = ["mission_itemAction", "Mission Action", "", {
    params ["_item"];

    deleteVehicle _item;
}, {true}] call ace_interact_menu_fnc_createAction;
[_obj, 0, ["ACE_MainActions"], _action] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, _obj];

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

["Completed1", true, true, true] remoteExec ["BIS_fnc_endMission"];

//call mission failed

["Failed1", false, true, true] remoteExec ["BIS_fnc_endMission"];
