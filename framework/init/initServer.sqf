if (!isMultiplayer) then {
	[] call mf_debugLoadout_fnc;
};

if (isMultiplayer) then {
	if (!isNil "ZE_Zeus") then {
		deleteVehicle ZE_Zeus;
	};
};

mf_playersKilled = 0;
mf_aiKilled = 0;
publicVariable "mf_playersKilled";
publicVariable "mf_aiKilled";

addMissionEventHandler ["EntityKilled", {
	_unitKilled = _this select 0;

	if (_unitKilled isKindOf "CAManBase") then {
		if (isPlayer _unitKilled) then {
			mf_playersKilled = mf_playersKilled + 1;
			publicVariable "mf_playersKilled";
		} else {
			mf_aiKilled = mf_aiKilled + 1;
			publicVariable "mf_aiKilled";
		};
	};
}];

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	[mf_fnc_fixAcreDesync, 20, []] call CBA_fnc_addPerFrameHandler;
};
