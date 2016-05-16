_unit = _this select 0;

if (!isServer) exitWith {};

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	if (!isPlayer _unit) then {
		removeAllItems _unit;
	};
};

if (!isNil "murshun_customEnemyLoadouts") then {
	if (murshun_customEnemyLoadouts) then {
		if (!(_unit in (switchableUnits + playableUnits))) then {
			[_unit] call mf_fnc_giveLoadout;
		};
	};	
};
