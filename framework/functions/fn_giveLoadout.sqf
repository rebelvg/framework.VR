_unit = _this select 0;
_className = toLower getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");

_loadoutArray = [];

switch (side _unit) do {
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
		{
			_allClassesArray = _allClassesArray + [toLower _x];
		} foreach (_x select 0);
	} foreach (_loadoutArray select 0);

	if (!(_className in _allClassesArray)) then {
		systemChat format ["Can't find loadout for %1, falling back to rifleman.", _className];

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
					if (_className in (_x select 0) || "all" in (_x select 0)) then {
						_itemsArray = _x select 1;
						_linkItemsArray = _x select 2;

						[_unit, _itemsArray] call murshun_giveItems_fnc;
						[_unit, _linkItemsArray] call murshun_giveLinkItems;
					};
				};
			} foreach (_loadoutArray select 1);

			{
				[_unit, _x] call murshun_giveWeapon_fnc;
			} foreach _weaponsArray;
		};
	} foreach (_loadoutArray select 0);	
};

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	if (!isPlayer _unit) then {
		removeAllItems _unit;
	};
};
