waitUntil {!isNil "murshun_frameworkInit"};

if (!(isClass (configFile >> "CfgPatches" >> "acre_main"))) then {
	[player] call mf_fnc_giveLoadout;
	[] execVM "scripts\tfarSettings.sqf";
	
	ace_respawn_SavePreDeathGear = true;
} else {
	ace_respawn_SavePreDeathGear = false;
};

[player] spawn murshun_assignTeam_fnc;

if (didJIP) then {
	[[[2, false, true], "scripts\roster.sqf"], "BIS_fnc_execVM"] call BIS_fnc_MP;
} else {
	[2, false, true] execVM "scripts\roster.sqf";
};

[] spawn {
	while {true} do {
		_showHUD = [true,true,false,false,false,false,false,true];

		_currentShowHUD = shownHUD;
		if (!(_currentShowHUD isEqualTo _showHUD)) then {
			showHUD _showHUD;
		};
		
		sleep 1;
	};
};

waitUntil {time > 90};

_monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

_month = date select 1;
_month = _monthArray select _month - 1;
_dateArray = date;

{
	if (_x < 10) then {
		_dateArray set [_forEachIndex, "0" + str _x];
	} else {
		_dateArray set [_forEachIndex, str _x];
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

if (_murshun_whoDunIt == "") exitWith {};

[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>%1</t><br /><t shadow='2' align='right' size='1.6'>%2</t>", "Created and Directed", "by " + _murshun_whoDunIt], true, nil, 9, 1, 0] spawn BIS_fnc_textTiles;
