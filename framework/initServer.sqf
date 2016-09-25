if (!isMultiplayer) then {
	[] call mf_disableAI_fnc;
	[] call mf_debugLoadout_fnc;
};

if (isMultiplayer) then {
	if (!isNil "ZE_Zeus") then {
		deleteVehicle ZE_Zeus;
	};
};

murshun_framework_playersKilled = 0;
murshun_framework_unitsKilled = 0;
publicVariable "murshun_framework_playersKilled";
publicVariable "murshun_framework_unitsKilled";

addMissionEventHandler ["EntityKilled", {
	_unitKilled = _this select 0;
	
	if (_unitKilled isKindOf "CAManBase") then {
		if (isPlayer _unitKilled) then {
			murshun_framework_playersKilled = murshun_framework_playersKilled + 1;
			publicVariable "murshun_framework_playersKilled";
		} else {
			murshun_framework_unitsKilled = murshun_framework_unitsKilled + 1;
			publicVariable "murshun_framework_unitsKilled";
		};
	};
}];

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	[mf_fnc_fixAcreDesync, 20, []] call CBA_fnc_addPerFrameHandler;
};
