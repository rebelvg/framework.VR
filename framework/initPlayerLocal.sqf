_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf player >> "displayName");

[player, _className] execVM "scripts\loadout.sqf";

if (!(didJIP)) then {
[2, false, true] execVM "scripts\roster.sqf";
} else {
if (time > 1) then {
[[[2, false, true], "scripts\roster.sqf"], "BIS_fnc_execVM"] call BIS_fnc_MP;
} else {
[2, false, true] execVM "scripts\roster.sqf";
};
};

[] execVM "scripts\radio_settings.sqf";

sleep 90;

_monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

_month = date select 1;

_month = _monthArray select _month - 1;

_dateArray = date;

{
_indexId = _dateArray find _x;
if (_x < 10) then {
_dateArray set [_indexId, "0" + str(_x)];
} else {
_dateArray set [_indexId, str(_x)];
};
} foreach _dateArray;

[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", (_dateArray select 2) + "." + _month + "." + (_dateArray select 0), (_dateArray select 3) + ":" + (_dateArray select 4)], true, nil, 9, 1, 0] spawn BIS_fnc_textTiles;

sleep 11;

{
[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>%1</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", "Starring", name _x], true, nil, 1, 0.5, 0] spawn BIS_fnc_textTiles;
sleep 1.5;
} foreach allPlayers;

sleep 0.5;

[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", briefingName, toUpper worldName], true, nil, 9, 1, 0] spawn BIS_fnc_textTiles;

sleep 11;

_murshun_whoDunIt = getText (missionConfigFile >> "author");
if (isNil "_murshun_whoDunIt") exitWith {};
if (_murshun_whoDunIt == "") exitWith {};

[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>%1</t><br /><t shadow='2' align='right' size='1.6'>%2</t>", "Created and Directed by", _murshun_whoDunIt], true, nil, 9, 1, 0] spawn BIS_fnc_textTiles;
