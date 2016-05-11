if (!isMultiplayer) then {
	[] call mf_disableAI_fnc;
	[] spawn mf_debugLoadout_fnc;

	[player] spawn BIS_fnc_traceBullets;
};

murshun_debriefing_text = "";

addMissionEventHandler ["Ended", {
	murshun_debriefing_text = format ["---Friendly Fire Logs---<br/>%1<br/>---Spectators---<br/>%2<br/>---Players---<br/>%3", str (murshun_ffArray apply {(_x select 1) + " damaged " + (_x select 0) + " " + str floor(time - (_x select 2)) + " seconds ago"}), str murshun_respawnArray, str (allPlayers apply {name _x})];
}];
