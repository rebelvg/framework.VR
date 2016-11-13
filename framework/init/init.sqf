if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	[false, true] call acre_api_fnc_setupMission;
	[true] call acre_api_fnc_setRevealToAI;
	[0] call acre_api_fnc_setLossModelScale;
	[true] call acre_api_fnc_setInterference;
	[false] call acre_api_fnc_setFullDuplex;
	[true] call acre_api_fnc_ignoreAntennaDirection;
};
