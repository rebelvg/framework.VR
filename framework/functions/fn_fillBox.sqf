_unit = _this select 0;
_side = _this select 1;

if (!isServer) exitWith {};

_loadoutArray = [];

waitUntil {time > 0};

if (isNil "_side") then {
	_side = side _unit;
};

_unit setVariable ["tf_side", _side, true];

switch (_side) do {
case WEST: {
		_loadoutArray = call mf_fnc_loadoutWest;
	};
case EAST: {
		_loadoutArray = call mf_fnc_loadoutEast;
	};
case RESISTANCE: {
		_loadoutArray = call mf_fnc_loadoutGuer;
	};
case CIVILIAN: {
		_loadoutArray = call mf_fnc_loadoutCiv;
	};
};

if (!isMultiplayer) then {
	if (_unit isKindOf "thing") then {
		_unit addAction ["Virtual Arsenal", {["Open", true] call BIS_fnc_arsenal}];
	};
};

if (count _loadoutArray == 3) then {
	clearMagazineCargoGlobal _unit;
	clearWeaponCargoGlobal _unit;
	clearItemCargoGlobal _unit;
	clearBackpackCargoGlobal _unit;

	if (_unit isKindOf "thing") then {
		_unit allowDamage false;
		
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
		
		[_unit, 1/4] call murshun_fillBox_fnc;

		if (_unit isKindOf "car") then {
			[_unit, 3] call ace_repair_fnc_addSpareParts;
		};

		if (_unit isKindOf "tank") then {
			[_unit, 3] call ace_repair_fnc_addSpareParts;
		};

		if (_unit isKindOf "air") then {
			_unit addBackpackCargoGlobal ["B_Parachute", count fullCrew [_unit, "", true]];
		};
	};
};
