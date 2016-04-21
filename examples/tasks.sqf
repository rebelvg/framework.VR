//https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul

/*
//creates task, waits until the hostage is 50m from the base marker, completes task

[BluFor, "blufor_task_01", ["Task description.<br/><br/><img image='logo.paa' width='256' height='256'/>", "Hostage Task"], "task_01_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	hostage distance getMarkerPos "base_marker" < 50
};

["blufor_task_01", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//creates task, waits until objects are not alive, completes task

_objArray = [obj_01, obj_02, obj_03];

[BluFor, "blufor_task_02", ["Task description.", "Search And Destroy"], "task_02_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	{alive _x} count _objArray == 0
};

["blufor_task_02", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//creates task, waits until at least one player is 50m from the objective marker, completes task

[BluFor, "blufor_task_03", ["Task description.", "Check This Position"], "task_03_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	{_x distance getMarkerPos "task_03_marker" < 50} count allPlayers > 0
};

["blufor_task_03", "Succeeded", true] call BIS_fnc_taskSetState;
*/

/*
//creates task, waits until more than 80% of players (not spectators) are 50m from the base marker, completes task

[BluFor, "blufor_task_04", ["Task description.", "RTB"], "base_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	{_x distance getMarkerPos "base_marker" < 50} count allPlayers > ({!isObjectHidden _x} count allPlayers) * 0.8
};

["blufor_task_04", "Succeeded", true] call BIS_fnc_taskSetState;
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
