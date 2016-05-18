if (!isMultiplayer) then {
	[] call mf_disableAI_fnc;
	[] spawn mf_debugLoadout_fnc;

	[player] spawn BIS_fnc_traceBullets;
};

murshun_debriefing_text = "";

addMissionEventHandler ["Ended", {
	murshun_debriefing_text = format [
	"---Friendly Fire Logs---<br/>
	%1<br/>
	---Spectators---<br/>
	%2<br/>
	---Players---<br/>
	%3<br/>
	---Players Killed---<br/>
	%4<br/>
	---AI Killed---<br/>
	%5
	",
	str (murshun_ffArray apply {(_x select 1) + " damaged " + (_x select 0) + " " + str ceil ((time - (_x select 2))/60) + " minutes ago"}),
	str murshun_respawnArray,
	str (allPlayers apply {name _x}),
	murshun_framework_playersKilled,
	murshun_framework_unitsKilled
	];
}];

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	[false, true] call acre_api_fnc_setupMission;
	[true] call acre_api_fnc_setRevealToAI;
	[0] call acre_api_fnc_setLossModelScale;
	[false] call acre_api_fnc_setFullDuplex;
};

if (!isNil "mf_onlyPilotsCanFly") then {
	if (mf_onlyPilotsCanFly) then {
		player addEventHandler ["GetInMan", {
			_unit = _this select 0;
			_className = tolower gettext (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
			
			if ([_unit] call mf_fnc_isUnitPilot) then {
				if (_className != "pilot") then {
					unassignVehicle _unit;
					moveOut _unit;
					
					systemChat "Only pilots can fly.";
				};
			};
		}];
		
		player addEventHandler ["SeatSwitchedMan", {
			_unit = _this select 0;
			_className = tolower gettext (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
			
			if ([_unit] call mf_fnc_isUnitPilot) then {
				if (_className != "pilot") then {
					_veh = _this select 0;
					
					if ((getPosATL _veh) select 2 < 5) then {
						unassignVehicle _unit;
						moveOut _unit;
						
						systemChat "Can change sits only when flying.";
					};
				};
			};
		}];
	};
};
