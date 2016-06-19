[] spawn {
	removeAllItems player;
	cutText ["", "BLACK FADED"];
	
	["mf_killed", 0, true] call ace_common_fnc_setHearingCapability;
	sleep 10;
	["mf_killed", 0, false] call ace_common_fnc_setHearingCapability;
};
