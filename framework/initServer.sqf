if (!isMultiplayer) then {
	[] call mf_disableAI_fnc;
	[] call mf_debugLoadout_fnc;
	
	DAC_Com_Values = [1,2,3,1];
	DAC_Marker = 2;
};

if (!isNil "ZE_Zeus") then {
	if (isMultiplayer) then {
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
