//0 = [this] execVM "mission\boxes\box_01.sqf";

params ["_box"];

if (!isServer) exitWith {};

waitUntil {time > 0};

clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

_box addItemCargoGlobal ["SmokeShellBlue", 10];
_box addBackpackCargoGlobal ["B_Kitbag_cbr", 10];
