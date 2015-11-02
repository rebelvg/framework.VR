debugLoadout_fnc = {
{
_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf _x >> "displayName");

_playerSide = str (side _x);

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
