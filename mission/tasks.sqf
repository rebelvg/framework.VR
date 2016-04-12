//place all mission related stuff here
//do not overwrite this file when copying framework from mission to mission

//task example
//task will be created at start
//task will be completed after 60 seconds
//mission end will be triggered after 15 seconds

/*
[BluFor, "blufor_task_01", ["First task description.", "First Task", "base_marker"], "base_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	time > 60
};

["blufor_task_01", "Succeeded", true] call BIS_fnc_taskSetState;

sleep 15;

[{
	["Completed1", true, true, true] call BIS_fnc_endMission;
},"BIS_fnc_spawn"] call BIS_fnc_MP;
*/
