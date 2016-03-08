//place all mission related stuff here
//do not overwrite this file when copying framework from mission to mission

//task example
//task will be created at start
//task will be completed after 60 seconds

/*
[BluFor, "task_01", ["First task description.", "First Task", "base_marker"], "base_marker", "ASSIGNED", 0, true, "Default"] call BIS_fnc_taskCreate;

waitUntil {
	time > 60
};

["task_01", "Succeeded", true] call BIS_fnc_taskSetState;
*/
