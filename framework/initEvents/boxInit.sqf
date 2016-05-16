_box = _this select 0;

if (!isServer) exitWith {};

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	clearItemCargoGlobal _box;
};
