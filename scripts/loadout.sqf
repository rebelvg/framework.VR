_unit = _this select 0;
_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf _unit >> "displayName");

_loadoutArray = [];

waitUntil {!isNil "murshun_frameworkInit"};
waitUntil {!isNil "loadoutArray_west" or !isNil "loadoutArray_east" or !isNil "loadoutArray_guer" or !isNil "loadoutArray_civ"};

switch (side _unit) do {
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

if (count _loadoutArray == 3) then {
	removeAllAssignedItems _unit;
	removeAllWeapons _unit;
	removeBackpack _unit;
	removeAllItems _unit;
	removeGoggles _unit;
	removeUniform _unit;
	removeVest _unit;
	removeHeadgear _unit;
	
	_allClassesArray = [];
	
	{
		_allClassesArray = _allClassesArray + (_x select 0);
	} foreach (_loadoutArray select 0);
	
	if (!(_className in _allClassesArray)) then {
		systemchat format ["Can't find loadout for %1, falling back to rifleman.", _className];
		_className = "rifleman";
	};

	{
		if (_className in (_x select 0)) then {
			_fashionArray = _x select 1 select 0;
			_weaponsArray = _x select 1 select 1;
			
			if (count _fashionArray == 5) then {
				[_unit, _fashionArray select 0] call murshun_giveUniform_fnc;
				[_unit, _fashionArray select 1] call murshun_giveVest_fnc;
				[_unit, _fashionArray select 2] call murshun_giveHeadgear_fnc;
				[_unit, _fashionArray select 3] call murshun_giveBackpack_fnc;
				[_unit, _fashionArray select 4] call murshun_giveGoggles_fnc;
			};

			{
				if (count _x == 3) then {		
					[_unit, _x] call murshun_giveWeapon_fnc;
				};
			} foreach _weaponsArray;
		};
	} foreach (_loadoutArray select 0);

	[_unit, _loadoutArray select 1 select 0] call murshun_giveItems_fnc;
	[_unit, _loadoutArray select 1 select 1] call murshun_giveLinkItems;	

	[_unit] call murshun_giveMedicalSupplies_fnc;
};
