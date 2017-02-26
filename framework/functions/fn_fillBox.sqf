params ["_box", ["_side", sideEmpty]];

if (!isMultiplayer || mf_forceVirtualArsenal || ("AddVirtualArsenal" call BIS_fnc_getParamValue) == 1) then {
    if (_box isKindOf "thing") then {
        _box addAction ["Virtual Arsenal", {["Open", true] spawn BIS_fnc_arsenal}];
    } else {
        _action = ["mf_va_veh_action", "Virtual Arsenal", "", {["Open", true] spawn BIS_fnc_arsenal}, {true}] call ace_interact_menu_fnc_createAction;
        [_box, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    }
};

if (mf_addParadropOption) then {
    if (_box isKindOf "thing") then {
        _action = ["mf_paradrop_action", "Paradrop to Your Team", "", {[player] spawn mf_teamParadrop_fnc}, {!isNil "mf_teamParadrop_fnc"}] call ace_interact_menu_fnc_createAction;
        [_box, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };
};

if (!isServer) exitWith {};

_loadoutArray = [];

waitUntil {time > 0};

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

clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

if (count _loadoutArray == 3) then {
	if (_box isKindOf "thing") then {
		_box allowDamage false;

		[_box, 1] call murshun_fillBox_fnc;
	} else {
		[_box, 1/4] call murshun_fillBox_fnc;

		if (_box isKindOf "car") then {
			[_box, 7, "ACE_Wheel"] call ace_repair_fnc_addSpareParts;
		};

		if (_box isKindOf "tank") then {
			[_box, 3, "ACE_Track"] call ace_repair_fnc_addSpareParts;
		};

		if (_box isKindOf "air") then {
			_box addBackpackCargoGlobal ["B_Parachute", count fullCrew [_box, "", true]];
		};
	};
};

[_box] spawn mf_fnc_dynamicItems;
