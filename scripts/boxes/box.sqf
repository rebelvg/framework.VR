_unit = _this select 0;
_side = _this select 1;

if (!isServer) exitWith {};

_loadoutArray = [];

waitUntil {!isNil "murshun_frameworkInit"};
waitUntil {time > 1 and (!isNil "loadoutArray_west" or !isNil "loadoutArray_east" or !isNil "loadoutArray_guer" or !isNil "loadoutArray_civ")};

if (isNil "_side") then {
	_side = side _unit;
};

switch (_side) do {
case WEST: {
		_loadoutArray = ["loadoutArray_west"] call murshun_checkArrayExists_fnc;
	};
case EAST: {
		_loadoutArray = ["loadoutArray_east"] call murshun_checkArrayExists_fnc;
	};
case RESISTANCE: {
		_loadoutArray = ["loadoutArray_guer"] call murshun_checkArrayExists_fnc;
	};
case CIVILIAN: {
		_loadoutArray = ["loadoutArray_civ"] call murshun_checkArrayExists_fnc;
	};
};

if (count _loadoutArray == 4) then {
	clearMagazineCargoGlobal _unit;
	clearWeaponCargoGlobal _unit;
	clearitemcargoGlobal _unit;
	clearBackpackCargoGlobal _unit;

	if (_unit isKindOf "thing") then {
		_unit allowDamage false;

		if (!isMultiplayer) then {
			_unit addAction ["Virtual Arsenal",{["Open",true] call BIS_fnc_arsenal}];
		};
		
		[_unit, 1] call murshun_fillBox_fnc;
	} else {
		if (ace_medical_level > 1) then {
			_unit addItemCargoGlobal ["ACE_elasticBandage", 100];
			_unit addItemCargoGlobal ["ACE_quikclot", 100];
			_unit addItemCargoGlobal ["ACE_morphine", 25];
			_unit addItemCargoGlobal ["ACE_epinephrine", 25];
			_unit addItemCargoGlobal ["ACE_atropine", 25];
			_unit addItemCargoGlobal ["ACE_tourniquet", 10];
			_unit addItemCargoGlobal ["ACE_personalAidKit", 5];
			_unit addItemCargoGlobal ["ACE_salineIV_500", 5];
		} else {
			_unit addItemCargoGlobal ["ACE_elasticBandage", 100];
			_unit addItemCargoGlobal ["ACE_morphine", 25];
			_unit addItemCargoGlobal ["ACE_epinephrine", 25];
			_unit addItemCargoGlobal ["ACE_salineIV_500", 5];
		};
		
		[_unit, 4] call murshun_fillBox_fnc;

		if (_unit isKindOf "car") then {
			[_unit, 3] call ace_repair_fnc_addSpareParts;
		};

		if (_unit isKindOf "tank") then {
			[_unit, 3] call ace_repair_fnc_addSpareParts;
		};

		if (_unit isKindOf "air") then {
			_unit addBackpackCargoGlobal ["B_Parachute", count fullCrew [_unit, "", true]];
		};

		if (!isNil "murshun_enableRadioInCars") then {
			if (murshun_enableRadioInCars) then {
				[_unit] execVM "music_radio\vehicleInit.sqf";
			};
		};
	};
};
