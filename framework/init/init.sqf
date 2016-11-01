if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	[false, true] call acre_api_fnc_setupMission;
	[true] call acre_api_fnc_setRevealToAI;
	[0] call acre_api_fnc_setLossModelScale;
	[true] call acre_api_fnc_setInterference;
	[false] call acre_api_fnc_setFullDuplex;
	[true] call acre_api_fnc_ignoreAntennaDirection;
};

if (isNil "murshun_ffArray") then {
	murshun_ffArray = [];
};

if (isNil "murshun_respawnArray") then {
	murshun_respawnArray = [];
};

addMissionEventHandler ["Ended", {
	mf_debriefingText = format [
	"---Friendly Fire Logs---<br/>
	%1<br/>
	---Spectators---<br/>
	%2<br/>
	---Players---<br/>
	%3<br/>
	---Players Killed---<br/>
	%4<br/>
	---AI Killed---<br/>
	%5",
	str (murshun_ffArray apply {(_x select 1) + " damaged " + (_x select 0) + " " + str ceil ((CBA_missionTime - (_x select 2))/60) + " minutes ago"}),
	str murshun_respawnArray,
	str (allPlayers apply {name _x}),
	mf_playersKilled,
	mf_aiKilled
	];
}];
