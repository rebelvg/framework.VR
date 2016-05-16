_vehicle = _this select 0;

[_vehicle] execVM "musicRadio\radioInit.sqf";

if (!isServer) exitWith {};

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	clearItemCargoGlobal _vehicle;
};
