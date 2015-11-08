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

murshun_assignTeam_fnc = {
_unit = _this select 0;
_radio_channel = _unit getVariable ["radio_channel", [1, 0]];

_squad = _radio_channel select 0;
_team = _radio_channel select 1;

_teamsArray = ["MAIN", "RED", "GREEN", "BLUE", "YELLOW"];

waituntil {time > 1};

if (_team == 0) exitWith {};
if (_team > 4) exitWith {systemChat "Can't set color for this team.";};

[[_unit, _teamsArray select _team], "ace_interaction_fnc_joinTeam"] call BIS_fnc_MP;
};

if (!isMultiplayer) then {
{
if (!isPlayer _x) then {
_x disableAI "MOVE";
};
} foreach switchableUnits;
[] spawn debugLoadout_fnc;
};
