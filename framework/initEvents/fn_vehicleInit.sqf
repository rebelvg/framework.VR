_vehicle = _this select 0;

[_vehicle] call mf_fnc_onlyPilotsCanFlyVehicle;

if (!isServer) exitWith {};

clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
