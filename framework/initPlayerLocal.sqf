radioNetArray = [["101", "102", "103", "104", "105", "106", "107", "108"], ["111", "112", "113", "114", "115", "116", "117", "118"], ["121", "122", "123", "124", "125", "126", "127", "128"], ["131", "132", "133", "134", "135", "136", "137", "138"], ["141", "142", "143", "144", "145", "146", "147", "148"], ["151", "152", "153", "154", "155", "156", "157", "158"], ["161", "162", "163", "164", "165", "166", "167", "168"], ["171", "172", "173", "174", "175", "176", "177", "178"]];

_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf player >> "displayName");

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

if (serverTime < 1) then {
[2, false, true] execVM "scripts\roster.sqf";
} else {
[[[2, false, true], "scripts\roster.sqf"], "BIS_fnc_execVM"] call BIS_fnc_MP;
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

[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>%1</t><br /><t shadow='2' align='right' size='1.6'>%2</t>", "Created and Directed by", "Rebel"], true, nil, 9, 1, 0] spawn BIS_fnc_textTiles;
