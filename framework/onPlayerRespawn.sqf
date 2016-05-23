if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	[player] call mf_fnc_giveLoadout;
	[] execVM "scripts\acreSettings.sqf";
};
