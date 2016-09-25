murshun_giveUniform_fnc = {
	_unit = _this select 0;
	_string = _this select 1;

	if (count _string != 0) then {
		_unit forceAddUniform _string;
	};
};

murshun_giveVest_fnc = {
	_unit = _this select 0;
	_string = _this select 1;

	if (count _string != 0) then {
		_unit addVest _string;
	};
};

murshun_giveHeadgear_fnc = {
	_unit = _this select 0;
	_string = _this select 1;

	if (count _string != 0) then {
		_unit addHeadgear _string;
	};
};

murshun_giveBackpack_fnc = {
	_unit = _this select 0;
	_string = _this select 1;

	if (count _string != 0) then {
		_unit addBackpack _string;
	};
};

murshun_giveGoggles_fnc = {
	_unit = _this select 0;
	_string = _this select 1;

	if (count _string != 0) then {
		_unit addGoggles _string;
	};
};

murshun_giveWeapon_fnc = {
	_unit = _this select 0;
	_array = _this select 1;

	if (count _array == 3) then {
		_weapon = _array select 0;
		_mags = _array select 1;
		_devices = _array select 2;

		if (count _weapon != 0) then {
			_unit addWeapon _weapon;
		};
		
		{
			if (count _x == 2) then {
				if (count (_x select 0) != 0) then {
					if (([_weapon] call ace_common_fnc_getItemType) select 1 == "primary") then {
						_unit addPrimaryWeaponItem (_x select 0);
					};
					if (([_weapon] call ace_common_fnc_getItemType) select 1 == "handgun") then {
						_unit addHandgunItem (_x select 0);
					};
					if (([_weapon] call ace_common_fnc_getItemType) select 1 == "secondary") then {
						_unit addSecondaryWeaponItem (_x select 0);
					};
				};
			};
		} forEach _mags;
		
		{
			if (count _x == 2) then {
				if (count (_x select 0) != 0) then {
					_unit addMagazines _x;
				};
			};
		} forEach _mags;

		{
			if (count _x != 0) then {
				if (([_weapon] call ace_common_fnc_getItemType) select 1 == "primary") then {
					_unit addPrimaryWeaponItem _x;
				};
				if (([_weapon] call ace_common_fnc_getItemType) select 1 == "handgun") then {
					_unit addHandgunItem _x;
				};
				if (([_weapon] call ace_common_fnc_getItemType) select 1 == "secondary") then {
					_unit addSecondaryWeaponItem _x;
				};
			};
		} forEach _devices;
	};
};

murshun_giveItems_fnc = {
	_unit = _this select 0;
	_array = _this select 1;

	{
		if (count _x == 2) then {
			if (count (_x select 0) != 0) then {
				for "_i" from 1 to (_x select 1) do {_unit addItem (_x select 0)};
			};
		};
	} forEach _array;
};

murshun_giveLinkItems = {
	_unit = _this select 0;
	_array = _this select 1;

	{
		if (count _x != 0) then {
			_unit linkItem _x;
		};
	} forEach _array;
};

murshun_fillBox_fnc = {
	_unit = _this select 0;
	_multiplier = _this select 1;

	{
		_weaponsArray = _x select 1 select 1;
		
		{
			if (count _x == 3) then {
				_mags = _x select 1;
				
				{
					if (count _x == 2) then {
						if (count (_x select 0) != 0) then {
							_unit addMagazineCargoGlobal [_x select 0, ceil (60 * _multiplier)];
						};
					};
				} forEach _mags;
			};
		} forEach _weaponsArray;

	} forEach (_loadoutArray select 0);

	{
		if (count _x == 2) then {
			if (count (_x select 0) != 0) then {
				_unit addItemCargoGlobal [_x select 0, ceil ((_x select 1) * _multiplier)];
			};
		};
	} forEach (_loadoutArray select 2);
};

mf_disableAI_fnc = {
	{
		_x disableAI "ANIM";
		_x switchMove "";
	} forEach (switchableUnits - [player]);
};

mf_debugLoadout_fnc = {
	{
		[_x] call mf_fnc_giveLoadout;
		[_x] call murshun_assignTeam_fnc;
	} forEach (switchableUnits - [player]);
};

murshun_assignTeam_fnc = {
	_unit = _this select 0;
	
	_mf_groupChannel = _unit getVariable ["mf_groupChannel", [6, 4]];
	_squad = _mf_groupChannel select 0;
	_team = _mf_groupChannel select 1;

	_teamsArray = ["MAIN", "RED", "GREEN", "BLUE", "YELLOW"];

	if (_team > 0 and _team < 5) then {
		[_unit, _teamsArray select _team] call ace_interaction_fnc_joinTeam;
	};
};

mf_fnc_dynamicItems = {
	_box = _this select 0;
	
	if (!(isClass (configFile >> "CfgPatches" >> "acre_main"))) exitWith {};
	
	_itemsArray = (getItemCargo _box) select 0;
	
	clearItemCargoGlobal _box;
	
	if (count _itemsArray == 0) exitWith {};
	
	{
		_box addItemCargoGlobal [_x, 2];
	} forEach _itemsArray;

	[{
		params ["_args", "_handle"];
		_box = _args select 0;
		_itemsArray = _args select 1;
		
		if (!alive _box) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
		};
		
		_getItemCargo = getItemCargo _box;
		
		{
			if (_x in (_getItemCargo select 0)) then {
				_index = (_getItemCargo select 0) find _x;
				
				if (_getItemCargo select 1 select _index < 2) then {
					_box addItemCargoGlobal [_x, 1];
				};
			} else {
				_box addItemCargoGlobal [_x, 2];
			};
		} foreach _itemsArray;
	}, 1/2, [_box, _itemsArray]] call CBA_fnc_addPerFrameHandler;
};

mf_fnc_isUnitPilot = {
	_unit = _this select 0;
	
	if (vehicle _unit == _unit) exitWith {false};
	
	_veh = (vehicle _unit);
	
	if (!(_veh isKindOf "air")) exitWith {false};
	
	_return = false;
	
	if (driver _veh == _unit) then {
		_return = true;
	};
	
	_return
};

mf_fnc_isUnitCoPilot = {
	_unit = _this select 0;
	
	if (vehicle _unit == _unit) exitWith {false};

	private ["_veh", "_cfg", "_trts", "_return", "_trt"];

	_veh = (vehicle _unit);
	_cfg = configFile >> "CfgVehicles" >> typeOf (_veh);
	_trts = _cfg >> "turrets";
	
	if (!(_veh isKindOf "air")) exitWith {false};

	_return = false;

	for "_i" from 0 to (count _trts - 1) do {
		_trt = _trts select _i;

		if (getNumber(_trt >> "isCoPilot") == 1) exitWith {
			_return = (_veh turretUnit [_i] == _unit);
		};
	};

	_return
};

mf_fnc_addVehicleRespawn = {
	params ["_vehicle", ["_side", sideEmpty]];
	
	if (!isServer) exitWith {};
	
	if (_vehicle isKindOf "Man") exitWith {};
	
	_vehicle setVariable ["mf_vehicleRespawnPos", getPosATL _vehicle];
	_vehicle setVariable ["mf_vehicleDir", getDir _vehicle];
	_vehicle setVariable ["mf_vehicleLoadoutSide", _side];
	
	_vehicle addMPEventHandler ["MPKilled", {
		_this spawn {
			params ["_vehicle"];
			
			if (!isServer) exitWith {};
			
			_spawnPos = _vehicle getVariable "mf_vehicleRespawnPos";
			_vehDir = _vehicle getVariable "mf_vehicleDir";
			_loadoutSide = _vehicle getVariable "mf_vehicleLoadoutSide";
			_vehClass = typeOf _vehicle;
			
			sleep 30;
			
			if (_vehicle distance _spawnPos < 100) then {
				deleteVehicle _vehicle;
			};
			
			_newVehicle = _vehClass createVehicle [0,0,0];
			_newVehicle setDir _vehDir;
			_newVehicle setPosATL _spawnPos;
			
			[_newVehicle, _loadoutSide] spawn mf_fnc_fillBox;
			[_newVehicle, _loadoutSide] spawn mf_fnc_addVehicleRespawn;
			
			_string = format ["Vehicle %1 respawned at %2.", _vehClass, _spawnPos];
			[_string, "systemChat"] call BIS_fnc_MP;
		};
	}];
};

ace_respawn_SavePreDeathGear = false;

if (!isMultiplayer) then {
	DAC_Com_Values = [1,2,3,1];
	DAC_Marker = 2;
};

mf_version = 1.0;
