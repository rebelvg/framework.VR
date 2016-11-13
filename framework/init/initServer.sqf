if (!isMultiplayer) then {
	[] call mf_debugLoadout_fnc;
};

if (isMultiplayer) then {
	if (!isNil "ZE_Zeus") then {
		deleteVehicle ZE_Zeus;
	};
};

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	[mf_fnc_fixAcreDesync, 20, []] call CBA_fnc_addPerFrameHandler;
};
