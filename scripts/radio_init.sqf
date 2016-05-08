_radio = _this select 0;

[_radio] execVM "music_radio\radioInit.sqf";

if (!isServer) exitWith {};

_radio setVariable ["tf_side", WEST, true];
_radio setVariable ["TF_RadioType", "tf_anarc210", true];
