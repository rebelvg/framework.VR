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
		} foreach _mags;
		
		{
			if (count _x == 2) then {
				if (count (_x select 0) != 0) then {
					_unit addMagazines _x;
				};
			};
		} foreach _mags;

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
		} foreach _devices;
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
	} foreach _array;
};

murshun_giveLinkItems = {
	_unit = _this select 0;
	_array = _this select 1;

	{
		if (count _x != 0) then {
			_unit linkItem _x;
		};
	} foreach _array;
};

murshun_fillBox_fnc = {
	_unit = _this select 0;
	_divider = _this select 1;

	{
		_weaponsArray = _x select 1 select 1;
		
		{
			if (count _x == 3) then {
				_mags = _x select 1;
				
				{
					if (count _x == 2) then {
						if (count (_x select 0) != 0) then {
							_unit addMagazineCargoGlobal [_x select 0, ceil (50 / _divider)];
						};
					};
				} foreach _mags;
			};
		} foreach _weaponsArray;

	} foreach (_loadoutArray select 0);

	{
		if (count _x == 2) then {
			if (count (_x select 0) != 0) then {
				_unit addItemCargoGlobal [_x select 0, ceil ((_x select 1) / _divider)];
			};
		};
	} foreach (_loadoutArray select 2);
};

debugLoadout_fnc = {
	{
		_x disableAI "ANIM";
	} foreach (switchableUnits - [player]);
	
	waitUntil {time > 0};
	
	{
		[_x] spawn mf_fnc_giveLoadout;
		[_x] spawn murshun_assignTeam_fnc;
	} foreach (switchableUnits - [player]);
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

murshun_debriefing_text = "";

addMissionEventHandler ["Ended", {
	murshun_debriefing_text = format ["---Friendly Fire Logs---<br/>%1<br/>---Spectators---<br/>%2<br/>---Players---<br/>%3", str (murshun_ffArray apply {(_x select 1) + " damaged " + (_x select 0) + " " + str floor(time - (_x select 2)) + " seconds ago"}), str murshun_respawnArray, str (allPlayers apply {name _x})];
}];

if (!isMultiplayer) then {
	[] spawn debugLoadout_fnc;

	[player] spawn BIS_fnc_traceBullets;
};

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

murshun_frameworkInit = true;
