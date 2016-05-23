_box = _this select 0;
_side = _this select 1;

if (!isServer) exitWith {};

_loadoutArray = [];

waitUntil {time > 0};

if (isNil "_side") then {
	_side = side _box;
};

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
	if (_box isKindOf "thing") then {
		_box addAction ["Virtual Arsenal", {["Open", true] call BIS_fnc_arsenal}];
	};
};

clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

if (count _loadoutArray == 3) then {
	if (_box isKindOf "thing") then {
		_box allowDamage false;
		
		[_box, 1] call murshun_fillBox_fnc;
	} else {
		_box setVariable ["tf_side", _side, true];
		
		if (ace_medical_level > 1) then {
			_box addItemCargoGlobal ["ACE_elasticBandage", 20];
			_box addItemCargoGlobal ["ACE_quikclot", 20];
		} else {
			_box addItemCargoGlobal ["ACE_elasticBandage", 20];
		};
		
		[_box, 1/4] call murshun_fillBox_fnc;

		if (_box isKindOf "car") then {
			[_box, 3] call ace_repair_fnc_addSpareParts;
		};

		if (_box isKindOf "tank") then {
			[_box, 3] call ace_repair_fnc_addSpareParts;
		};

		if (_box isKindOf "air") then {
			_box addBackpackCargoGlobal ["B_Parachute", count fullCrew [_box, "", true]];
		};
	};
};

[_box] spawn mf_fnc_dynamicItems;
