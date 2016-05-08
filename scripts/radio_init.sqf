_radio = _this select 0;

if (!isServer) exitWith {};

_radio setVariable ["tf_side", WEST, true];
_radio setVariable ["TF_RadioType", "tf_anarc210", true];

[[[_radio], "music_radio\radioInit.sqf"], "BIS_fnc_execVM", true, true] call BIS_fnc_MP;
