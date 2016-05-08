_unit = _this select 0;

if (!isServer) exitWith {};

waitUntil {time > 0};

if (isNil "murshun_customEnemyLoadouts") exitWith {};

if (!murshun_customEnemyLoadouts) exitWith {};

if (_unit in (switchableUnits + playableUnits)) exitWith {};

[_unit] execVM "scripts\loadout.sqf";
