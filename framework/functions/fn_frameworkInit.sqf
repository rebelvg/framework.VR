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
							_unit addMagazineCargoGlobal [_x select 0, ceil (40 * _multiplier)];
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
	} forEach (switchableUnits - [player]);
};

mf_debugLoadout_fnc = {
	waitUntil {time > 0};

	{
		[_x] call mf_fnc_giveLoadout;
		[_x] spawn murshun_assignTeam_fnc;
	} forEach (switchableUnits - [player]);
};

murshun_assignTeam_fnc = {
	_unit = _this select 0;
	_mf_groupChannel = _unit getVariable ["mf_groupChannel", [6, 4]];

	_squad = _mf_groupChannel select 0;
	_team = _mf_groupChannel select 1;

	_teamsArray = ["MAIN", "RED", "GREEN", "BLUE", "YELLOW"];

	waitUntil {time > 0};

	if (_team > 0 and _team < 5) then {
		[[_unit, _teamsArray select _team], "ace_interaction_fnc_joinTeam"] call BIS_fnc_MP;
	};
};

mf_fnc_dynamicItems = {
	_box = _this select 0;
	
	if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
		_itemsArray = (getItemCargo _box) select 0;
		
		clearItemCargoGlobal _box;
		
		if (count _itemsArray == 0) exitWith {};
		
		{
			_box addItemCargoGlobal [_x, 3];
		} forEach _itemsArray;
		
		while {alive _box} do {
			sleep (1/10);
			
			_getItemCargo = getItemCargo _box;
			
			{
				if (_x in (_getItemCargo select 0)) then {
					_index = (_getItemCargo select 0) find _x;
					
					if (_getItemCargo select 1 select _index < 3) then {
						_box addItemCargoGlobal [_x, 1];
					};
				} else {
					_box addItemCargoGlobal [_x, 3];
				};
			} foreach _itemsArray;
		};
	};	
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

radioNetArray_west = [["101", "102", "103", "104", "105", "106", "107", "108"], ["111", "112", "113", "114", "115", "116", "117", "118"], ["121", "122", "123", "124", "125", "126", "127", "128"], ["131", "132", "133", "134", "135", "136", "137", "138"], ["141", "142", "143", "144", "145", "146", "147", "148"], ["151", "152", "153", "154", "155", "156", "157", "158"], ["161", "162", "163", "164", "165", "166", "167", "168"], ["171", "172", "173", "174", "175", "176", "177", "178"]];

radioNetArray_east = [["201", "202", "203", "204", "205", "206", "207", "208"], ["211", "212", "213", "214", "215", "216", "217", "218"], ["221", "222", "223", "224", "225", "226", "227", "228"], ["231", "232", "233", "234", "235", "236", "237", "238"], ["241", "242", "243", "244", "245", "246", "247", "248"], ["251", "252", "253", "254", "255", "256", "257", "258"], ["261", "262", "263", "264", "265", "266", "267", "268"], ["271", "272", "273", "274", "275", "276", "277", "278"]];

radioNetArray_guer = [["301", "302", "303", "304", "305", "306", "307", "308"], ["311", "312", "313", "314", "315", "316", "317", "318"], ["321", "322", "323", "324", "325", "326", "327", "328"], ["331", "332", "333", "334", "335", "336", "337", "338"], ["341", "342", "343", "344", "345", "346", "347", "348"], ["351", "352", "353", "354", "355", "356", "357", "358"], ["361", "362", "363", "364", "365", "366", "367", "368"], ["371", "372", "373", "374", "375", "376", "377", "378"]];

radioNetArray_civ = [["401", "402", "403", "404", "405", "406", "407", "408"], ["411", "412", "413", "414", "415", "416", "417", "418"], ["421", "422", "423", "424", "425", "426", "427", "428"], ["431", "432", "433", "434", "435", "436", "437", "438"], ["441", "442", "443", "444", "445", "446", "447", "448"], ["451", "452", "453", "454", "455", "456", "457", "458"], ["461", "462", "463", "464", "465", "466", "467", "468"], ["471", "472", "473", "474", "475", "476", "477", "478"]];

//tfar block
tf_radio_channel_name = "TaskForceRadio";
tf_radio_channel_password = "123";
tf_terrain_interception_coefficient = 7;
tf_give_microdagr_to_soldier = false;

tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = false;
tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;

tf_west_radio_code = "_murshun";
tf_east_radio_code = "_murshun";
tf_guer_radio_code = "_murshun";

_freqs = [0,7,["31","32","33","34","35","36","37","38","39","40"],0,"_murshun",-1,0,false];
tf_freq_west_lr = _freqs;
tf_freq_east_lr = _freqs;
tf_freq_guer_lr = _freqs;

tf_freq_west = [0,7,radioNetArray_west select 0,0,"_murshun",-1,0,"_SP_PLAYER_",false];
tf_freq_east = [0,7,radioNetArray_east select 0,0,"_murshun",-1,0,"_SP_PLAYER_",false];
tf_freq_guer = [0,7,radioNetArray_guer select 0,0,"_murshun",-1,0,"_SP_PLAYER_",false];

murshun_frameworkInit = true;
