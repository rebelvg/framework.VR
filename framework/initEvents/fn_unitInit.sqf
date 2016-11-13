_unit = _this select 0;

if (!isServer) exitWith {};

if (!isMultiplayer) then {
	[_unit] call mf_disableAI_fnc;
};

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	if (!isPlayer _unit) then {
		removeAllItems _unit;
	};
};

if (!(_unit in (switchableUnits + playableUnits))) then {
    if (mf_customEnemyLoadouts) then {
        [_unit] call mf_fnc_giveLoadout;
    };

    if (side _unit in mf_forceSideNVGs) then {
        _unit linkItem "ACE_NVG_Gen1";
    };
};
