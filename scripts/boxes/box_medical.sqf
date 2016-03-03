_unit = _this select 0;

if (!isServer) exitWith {};

waituntil {time > 1};

clearMagazineCargoGlobal _unit;
clearWeaponCargoGlobal _unit;
clearItemCargoGlobal _unit;
clearBackpackCargoGlobal _unit;

_unit allowDamage false;

if (ace_medical_level > 1) then {
	_unit addItemCargoGlobal ["ACE_elasticBandage", 500];
	_unit addItemCargoGlobal ["ACE_quikclot", 500];
	_unit addItemCargoGlobal ["ACE_morphine", 100];
	_unit addItemCargoGlobal ["ACE_epinephrine", 100];
	_unit addItemCargoGlobal ["ACE_atropine", 100];
	_unit addItemCargoGlobal ["ACE_tourniquet", 50];
	_unit addItemCargoGlobal ["ACE_salineIV_500", 50];
	_unit addItemCargoGlobal ["ACE_personalAidKit", 50];
} else {
	_unit addItemCargoGlobal ["ACE_elasticBandage", 500];
	_unit addItemCargoGlobal ["ACE_morphine", 100];
	_unit addItemCargoGlobal ["ACE_epinephrine", 100];
	_unit addItemCargoGlobal ["ACE_salineIV_500", 50];
};
