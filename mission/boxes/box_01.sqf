//0 = [this] execVM "mission\boxes\box_01.sqf";

_box = _this select 0;

if (!isServer) exitWith {};

waitUntil {time > 0};

clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

_box addItemCargoGlobal ["SmokeShellBlue", 10];
