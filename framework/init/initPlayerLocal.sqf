[] call mf_fnc_frameworkBriefing;

[] call mf_fnc_radioBriefing;

if (didJIP) then {
	[[], "mf_fnc_teamRoster"] call BIS_fnc_MP;
} else {
	[] call mf_fnc_teamRoster;
};

[{!isNull findDisplay 46}, murshun_assignTeam_fnc, [player]] call CBA_fnc_waitUntilAndExecute;

[] call mf_fnc_onlyPilotsCanFlyPlayer;

if (!("base_marker" in allMapMarkers)) then {
	createMarkerLocal ["base_marker", getPos player];
};

if (!("respawn" in allMapMarkers)) then {
	createMarkerLocal ["respawn", getPos player];
};

waitUntil {time > 180};

_monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

_month = date select 1;
_month = _monthArray select (_month - 1);
_dateArray = date;

{
	if (_x < 10) then {
		_dateArray set [_forEachIndex, "0" + str _x];
	} else {
		_dateArray set [_forEachIndex, str _x];
	};
} forEach _dateArray;

[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br/><t shadow='2' align='right' size='1.4'>%2</t>", (_dateArray select 2) + "." + _month + "." + (_dateArray select 0), (_dateArray select 3) + ":" + (_dateArray select 4)], true, nil, 9, 1, 0] spawn BIS_fnc_textTiles;

sleep 11;

{
	[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>%1</t><br/><t shadow='2' align='right' size='1.4'>%2</t>", "Starring", name _x], true, nil, 1, 0.5, 0] spawn BIS_fnc_textTiles;
	sleep 1.5;
} forEach allPlayers;

sleep 0.5;

_worldName = getText (configFile >> "CfgWorlds" >> worldName >> "description");

[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br/><t shadow='2' align='right' size='1.4'>%2</t>", briefingName, _worldName], true, nil, 9, 1, 0] spawn BIS_fnc_textTiles;

sleep 11;

_whoDunIt = getMissionConfigValue ["author", "Murshun"];

[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>%1</t><br/><t shadow='2' align='right' size='1.6'>%2</t>", "Created and Directed", "by " + _whoDunIt], true, nil, 9, 1, 0] spawn BIS_fnc_textTiles;
