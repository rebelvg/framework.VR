if (!(isClass (configFile >> "CfgPatches" >> "acre_main"))) exitWith {};

_mf_groupChannel = player getVariable ["mf_groupChannel", [6, 4]];
_channel = _mf_groupChannel select 0;
_team = _mf_groupChannel select 1;

waitUntil {
	time > 0 and [] call acre_api_fnc_isInitialized
};

_343Radios = (items player) select {[_x] call acre_api_fnc_getBaseRadio == "ACRE_PRC343"};
_148Radios = (items player) select {[_x] call acre_api_fnc_getBaseRadio == "ACRE_PRC148"};
_152Radios = (items player) select {[_x] call acre_api_fnc_getBaseRadio == "ACRE_PRC152"};

if (count _343Radios > 0) then {
	[(_343Radios select 0), _channel + (_team - 1) * 16] call acre_api_fnc_setRadioChannel;
	[(_343Radios select 0), "LEFT"] call acre_api_fnc_setRadioSpatial;
	[(_343Radios select 0)] call acre_api_fnc_setCurrentRadio;
};

if (count _148Radios > 0) then {
	[(_148Radios select 0), _channel] call acre_api_fnc_setRadioChannel;
	[(_148Radios select 0), "LEFT"] call acre_api_fnc_setRadioSpatial;
};

if (count _152Radios > 0) then {
	[(_152Radios select 0), 33] call acre_api_fnc_setRadioChannel;
	[(_152Radios select 0), "RIGHT"] call acre_api_fnc_setRadioSpatial;
};
