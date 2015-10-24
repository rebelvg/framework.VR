_unit = (_this select 0);

if (!isServer) exitWith {};
clearMagazineCargoGlobal _unit;
clearWeaponCargoGlobal _unit;
clearitemcargoGlobal _unit;
clearBackpackCargoGlobal _unit;

_unit allowDamage false;

_unit addBackpackCargoGlobal ["B_Parachute", 60];
