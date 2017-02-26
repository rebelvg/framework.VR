params ["_box", ["_side", sideEmpty]];

if (!isMultiplayer || mf_forceVirtualArsenal || ("AddVirtualArsenal" call BIS_fnc_getParamValue) == 1) then {
    if (_box isKindOf "thing") then {
        _box addAction ["Virtual Arsenal", {["Open", true] spawn BIS_fnc_arsenal}];
    };
};

if (_box isKindOf "thing") then {
    _action = ["mf_paradrop_action", "Paradrop to Your Team", "", {[player] spawn mf_teamParadrop_fnc}, {mf_addParadropOption}] call ace_interact_menu_fnc_createAction;
    [_box, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ["mf_resetLoadout_action", "Reset Loadout", "", {
        [player] call mf_fnc_giveLoadout;
        [] spawn mf_fnc_acreSettings;
    }, {true}] call ace_interact_menu_fnc_createAction;
    [_box, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};

if (!isServer) exitWith {};

if (_box isKindOf "thing") then {
    _box allowDamage false;
};

_loadoutArray = [];

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

waitUntil {time > 0};

clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

if (_box isKindOf "car") then {
    [_box, 7, "ACE_Wheel"] call ace_repair_fnc_addSpareParts;
};

if (_box isKindOf "tank") then {
    [_box, 3, "ACE_Track"] call ace_repair_fnc_addSpareParts;
};

if (_box isKindOf "air") then {
    _box addBackpackCargoGlobal ["B_Parachute", count fullCrew [_box, "", true]];
};

if (count _loadoutArray == 0) exitWith {};

if (_box isKindOf "thing") then {
    [_box, 1] call murshun_fillBox_fnc;
} else {
    [_box, 1/4] call murshun_fillBox_fnc;
};

[_box] spawn mf_fnc_dynamicItems;
