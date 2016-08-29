if (!(isClass (configFile >> "CfgPatches" >> "task_force_radio"))) exitWith {};

_radioNetArray = [["101", "102", "103", "104", "105", "106", "107", "108"], ["111", "112", "113", "114", "115", "116", "117", "118"], ["121", "122", "123", "124", "125", "126", "127", "128"], ["131", "132", "133", "134", "135", "136", "137", "138"], ["141", "142", "143", "144", "145", "146", "147", "148"], ["151", "152", "153", "154", "155", "156", "157", "158"], ["161", "162", "163", "164", "165", "166", "167", "168"], ["171", "172", "173", "174", "175", "176", "177", "178"]];

_mf_groupChannel = player getVariable ["mf_groupChannel", [6, 4]];
_channel = _mf_groupChannel select 0;
_team = _mf_groupChannel select 1;

if (isNil {_radioNetArray select _channel}) exitWith {};

waitUntil {
	time > 0
};

if (!(call TFAR_fnc_haveSWRadio)) exitWith {};

_currentSwRadio = call TFAR_fnc_activeSwRadio;

{
	[_currentSwRadio, _forEachIndex + 1, _x] call TFAR_fnc_SetChannelFrequency;
} foreach (_radioNetArray select _channel);

_className = tolower gettext (configFile >> "CfgVehicles" >> typeOf player >> "displayName");

[_currentSwRadio, _team - 1] call TFAR_fnc_setSwChannel;

if (_className == "officer" or _className == "squad leader") then {
	[_currentSwRadio, 8, (_radioNetArray select 0) select 7] call TFAR_fnc_SetChannelFrequency;
	[_currentSwRadio, 7] call TFAR_fnc_setAdditionalSwChannel;
};

if (_className == "team leader") then {
	[_currentSwRadio, 8, (_radioNetArray select 0) select 7] call TFAR_fnc_SetChannelFrequency;
	[_currentSwRadio, 4] call TFAR_fnc_setAdditionalSwChannel;
};
