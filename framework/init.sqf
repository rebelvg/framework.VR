debugLoadout_fnc = {
{
if (side _x == side player) then {
_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf _x >> "displayName");

systemChat format ["init loadout - %1", _className];

_playerSide = str (side player);

switch (_playerSide) do {
	case "WEST": {
	[player, _className] execVM "scripts\loadout_west.sqf";
	};
	case "EAST": {
	[player, _className] execVM "scripts\loadout_east.sqf";
	};
	case "GUER": {
	[player, _className] execVM "scripts\loadout_guer.sqf";
	};	
};

sleep 5;

systemChat format ["init successful"];
};
} foreach switchableUnits;
};

testLoadout_fnc = {
{
if (side _x == side player) then {
_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf _x >> "displayName");

_playerSide = str (side player);

switch (_playerSide) do {
	case "WEST": {
	[_x, _className] execVM "scripts\loadout_west.sqf";
	};
	case "EAST": {
	[_x, _className] execVM "scripts\loadout_east.sqf";
	};
	case "GUER": {
	[_x, _className] execVM "scripts\loadout_guer.sqf";
	};	
};

};

[_x] spawn murshun_assignTeam_fnc;

} foreach switchableUnits - [player];
};

if (!isMultiplayer) then {
{
if (!isPlayer _x) then {
_x disableAI "MOVE";
};
} foreach switchableUnits;
};
