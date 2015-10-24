if (!isServer) exitWith {};
attackGroup = [];
[] execVM "scripts\Attack\StandardAttack.sqf";
[] execVM "scripts\Attack\VehicleAttack.sqf";
[] execVM "scripts\Attack\HeliAttack.sqf";
[] execVM "scripts\Attack\MortarAttack.sqf";
