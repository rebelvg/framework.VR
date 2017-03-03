murshun_giveUniform_fnc = {
    params ["_unit", "_className"];

    if (count _className != 0) then {
        _unit forceAddUniform _className;
    };
};

murshun_giveVest_fnc = {
    params ["_unit", "_className"];

    if (count _className != 0) then {
        _unit addVest _className;
    };
};

murshun_giveHeadgear_fnc = {
    params ["_unit", "_className"];

    if (count _className != 0) then {
        _unit addHeadgear _className;
    };
};

murshun_giveBackpack_fnc = {
    params ["_unit", "_className"];

    if (count _className != 0) then {
        _unit addBackpack _className;
    };
};

murshun_giveGoggles_fnc = {
    params ["_unit", "_className"];

    if (count _className != 0) then {
        _unit addGoggles _className;
    };
};

murshun_giveWeapon_fnc = {
    params ["_unit", "_weaponArray"];

    _weaponArray params [["_weapon", ""], ["_mags", []], ["_devices", []]];

    if (count _weapon != 0) then {
        _unit addWeapon _weapon;
    };

    {
        _x params [["_mag", ""], ["_count", 0]];

        if (count _mag != 0) then {
            if (([_weapon] call ace_common_fnc_getItemType) select 1 == "primary") then {
                _unit addPrimaryWeaponItem _mag;
            };
            if (([_weapon] call ace_common_fnc_getItemType) select 1 == "handgun") then {
                _unit addHandgunItem _mag;
            };
            if (([_weapon] call ace_common_fnc_getItemType) select 1 == "secondary") then {
                _unit addSecondaryWeaponItem _mag;
            };
        };
    } forEach _mags;

    {
        _x params [["_mag", ""], ["_count", 0]];

        if (count _mag != 0) then {
            _unit addMagazines [_mag, _count];
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

murshun_giveItems_fnc = {
    params ["_unit", "_array"];

    {
        _x params [["_item", ""], ["_count", 0]];

        if (count _item != 0) then {
            for "_i" from 1 to _count do {_unit addItem _item};
        };
    } forEach _array;
};

murshun_giveLinkItems = {
    params ["_unit", "_array"];

    {
        if (count _x != 0) then {
            _unit linkItem _x;
        };
    } forEach _array;
};

murshun_fillBox_fnc = {
    params ["_unit", "_multiplier"];

    _loadoutArray params [["_eqps", []], ["_items", []], ["_boxes", []]];

    {
        _x params [["_item", ""], ["_count", 0]];

        if (count _item != 0) then {
            _unit addItemCargoGlobal [_item, ceil (_count * _multiplier)];
        };
    } forEach _boxes;

    {
        _x params [["_classes", []], ["_eqp", []]];
        _eqp params [["_fashion", []], ["_weapons", []]];

        {
            _x params [["_weapon", ""], ["_mags", []]];

            {
                _x params [["_mag", ""], ["_count", 0]];

                if (count _mag != 0) then {
                    _unit addMagazineCargoGlobal [_mag, ceil (60 * _multiplier)];
                };
            } forEach _mags;
        } forEach _weapons;

        if ("rifleman" in (_classes apply {toLower _x})) then {
            {
                _x params [["_weapon", ""]];
                _unit addItemCargoGlobal [_weapon, ceil (5 * _multiplier)];
            } forEach _weapons;
        };
    } forEach _eqps;
};

mf_disableAI_fnc = {
    params ["_unit"];

    if (_unit in switchableUnits) then {
        if (!isPlayer _unit) then {
            _unit disableAI "ANIM";
            _unit switchMove "";
        };
    };
};

mf_debugLoadout_fnc = {
    {
        if (!isPlayer _x) then {
            [_x] call mf_fnc_giveLoadout;
            [_x] call murshun_assignTeam_fnc;
        };
    } forEach switchableUnits;
};

murshun_assignTeam_fnc = {
    params ["_unit"];

    _mf_groupChannel = _unit getVariable ["mf_groupChannel", [9, 5]];
    _mf_groupChannel params ["_squad", "_team"];

    _teamsArray = ["MAIN", "RED", "GREEN", "BLUE", "YELLOW"];

    if (_team > 0 and _team < 5) then {
        [_unit, _teamsArray select _team] call ace_interaction_fnc_joinTeam;
    };
};

mf_fnc_dynamicItems = {
    _box = _this select 0;

    if (!(isClass (configFile >> "CfgPatches" >> "acre_main"))) exitWith {};

    _itemsArray = (getItemCargo _box) select 0;

    if (count _itemsArray == 0) exitWith {};

    //clearItemCargoGlobal is broken for JIP clients, it hides weapons for JIP clients
    clearItemCargoGlobal _box;

    //"fix" removes weapons and adds them again
    _weaponsArray = getWeaponCargo _box;
    _weaponsArray params ["_items", "_count"];

    clearWeaponCargoGlobal _box;

    {
        _amount = _count select _forEachIndex;
        _box addItemCargoGlobal [_x, _amount];
    } forEach _items;

    {
        _box addItemCargoGlobal [_x, 2];
    } forEach _itemsArray;

    [{
        params ["_args", "_handle"];
        _args params ["_box", "_itemsArray"];

        if (!alive _box) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        _getItemCargo = getItemCargo _box;
        _getItemCargo params ["_items", "_count"];

        {
            if (_x in _items) then {
                _index = _items find _x;

                if (_count select _index < 2) then {
                    _box addItemCargoGlobal [_x, 1];
                };
            } else {
                _box addItemCargoGlobal [_x, 2];
            };
        } forEach _itemsArray;
    }, 1/2, [_box, _itemsArray]] call CBA_fnc_addPerFrameHandler;
};

mf_fnc_isUnitPilot = {
    _unit = _this select 0;

    if (vehicle _unit == _unit) exitWith {false};

    _veh = (vehicle _unit);

    if (!(_veh isKindOf "air")) exitWith {false};

    _simType = toLower getText (configFile >> "CfgVehicles" >> typeOf _veh >> "simulation");
    if (_simType == "parachute" or _simType == "paraglide") exitWith {false};

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

    _simType = toLower getText (configFile >> "CfgVehicles" >> typeOf _veh >> "simulation");
    if (_simType == "parachute" or _simType == "paraglide") exitWith {false};

    _return = false;

    for "_i" from 0 to (count _trts - 1) do {
        _trt = _trts select _i;

        if (getNumber (_trt >> "isCoPilot") == 1) exitWith {
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

            sleep 25;

            _wrecks = (allDead select {_x distance _spawnPos < 25});

            if (count _wrecks > 0) then {
                {
                    deleteVehicle _x;
                } forEach _wrecks;
            };

            sleep 5;

            _spawnPos params ["_x", "_y"];

            _newVehicle = _vehClass createVehicle ([[0,0,0], 50 * sqrt random 1, random 360] call BIS_fnc_relPos);
            _newVehicle setDir _vehDir;
            _newVehicle setPosATL [_x, _y, 0];

            [[_newVehicle, _loadoutSide], "mf_fnc_fillBox", true, true] call BIS_fnc_MP;
            [_newVehicle, _loadoutSide] spawn mf_fnc_addVehicleRespawn;

            _string = format ["Vehicle %1 respawned at %2.", _vehClass, mapGridPosition _spawnPos];
            [_string, "systemChat"] call BIS_fnc_MP;
        };
    }];
};

mf_fnc_addMusicRadio = {
    if (!isNil "murshun_musicRadio_fnc_addRadio") then {
        _this call murshun_musicRadio_fnc_addRadio;
    };
};

mf_teamParadrop_fnc = {
    _player = _this select 0;

    _code = {side _x == side _player && _x distance2d _player > 100 && !isObjectHidden _x && (vehicle _x == _x or (count fullCrew [vehicle _x, "", true] > count fullCrew [vehicle _x, "", false]))};

    _groupUnitsFar = (units group _player) select _code;

    if (count _groupUnitsFar == 0) then {
        _groupUnitsFar = allUnits select _code;
    };

    if (count _groupUnitsFar > 0) then {
        _unit = selectRandom _groupUnitsFar;

        if (vehicle _unit == _unit) then {
            _LX = (getPos _unit select 0) + (3 * sin ((getDir _unit) - 180));
            _LY = (getPos _unit select 1) + (3 * cos ((getDir _unit) - 180));
            _LZ = (getPos _unit select 2);

            _parachute = createVehicle ["Steerable_Parachute_F", [_LX,_LY,_LZ + 300], [], 0, "NONE"];
            _player moveInDriver _parachute;
        } else {
            _player moveInAny vehicle _unit;
        };

        _string = format ["%1 teleported to %2 using team paradrop.", name _player, name _unit];
        [_string, "systemChat"] call BIS_fnc_MP;
    } else {
        systemChat "Team members should be at least 100m away and not in a full vehicle.";
    };
};

if (!isNil "mf_forceVirtualArsenal") then {
    mf_forceVirtualArsenal = false;
};

if (!isNil "mf_customEnemyLoadouts") then {
    mf_customEnemyLoadouts = false;
};

if (!isNil "mf_onlyPilotsCanFly") then {
    mf_onlyPilotsCanFly = false;
};

if (!isNil "mf_forceSideNVGs") then {
    mf_forceSideNVGs = [];
};

if (!isNil "mf_addParadropOption") then {
    mf_addParadropOption = false;
};

if (!isNil "mf_debriefingText") then {
    mf_debriefingText = "";
};

if (!isMultiplayer) then {
    DAC_Com_Values = [1,2,3,1];
    DAC_Marker = 2;
};

mf_version = 1.37;
