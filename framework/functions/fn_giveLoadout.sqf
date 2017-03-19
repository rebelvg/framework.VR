_unit = _this select 0;
_className = toLower getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");

_loadoutArray = [];

switch (side group _unit) do {
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

if (count _loadoutArray == 0) exitWith {};

removeAllAssignedItems _unit;
removeAllWeapons _unit;
removeBackpack _unit;
removeAllItems _unit;
removeGoggles _unit;
removeUniform _unit;
removeVest _unit;
removeHeadgear _unit;

_allClassesArray = [];

_loadoutArray params [["_eqps", []], ["_items", []], ["_boxes", []]];

{
    _x params [["_classes", []]];

    {
        _allClassesArray = _allClassesArray + [toLower _x];
    } forEach _classes;
} forEach _eqps;

if (!(_className in _allClassesArray)) then {
    if (isPlayer _unit || !isMultiplayer) then {
        _string = format ["Loadout %2: Can't find loadout for %1, falling back to rifleman.", _className, side group _unit];
        [_string, "systemChat"] call BIS_fnc_MP;
    };

    _className = "rifleman";
};

{
    _x params [["_classes", []], ["_eqp", []]];
    _eqp params [["_fashion", []], ["_weapons", []]];
    _fashion params [["_uniform", ""], ["_vest", ""], ["_headgear", ""], ["_backpack", ""], ["_goggles", ""]];

    if (_className in _classes) then {
        [_unit, _uniform] call murshun_giveUniform_fnc;
        [_unit, _vest] call murshun_giveVest_fnc;
        [_unit, _headgear] call murshun_giveHeadgear_fnc;
        [_unit, _backpack] call murshun_giveBackpack_fnc;
        [_unit, _goggles] call murshun_giveGoggles_fnc;
    };
} forEach _eqps;

{
    _x params [["_classes", []], ["_itemsArray", []], ["_linkItemsArray", []]];

    if (_className in _classes || "all" in _classes) then {
        [_unit, _itemsArray] call murshun_giveItems_fnc;
        [_unit, _linkItemsArray] call murshun_giveLinkItems;
    };
} forEach _items;

{
    _x params [["_classes", []], ["_eqp", []]];
    _eqp params [["_fashion", []], ["_weapons", []]];

    if (_className in _classes) then {
        {
            [_unit, _x] call murshun_giveWeapon_fnc;
        } forEach _weapons;
    };
} forEach _eqps;

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
    if (!isPlayer _unit) then {
        removeAllItems _unit;
    };
};
