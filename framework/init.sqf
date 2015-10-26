loadoutArray = [
["TRYK_U_denim_jersey_blu", "TRYK_U_denim_jersey_blk", "TRYK_U_denim_hood_blk"], //uniform array 0
["TRYK_V_IOTV_BLK"], //vest array 1
["H_Bandanna_gry", "TRYK_H_woolhat"], //headgear array 2
["B_FieldPack_blk"], //backpack array 3
"", // radio backpack 4
["", ""], //facewear array 5
["ACE_EarPlugs", "ACE_Flashlight_XL50"], //items 6
["", ""], //personal radio 7, nvg
[["", "", ["", "", "", ""]]], //rifles array 8, mag, devices
["", "", "", ["", "", "", ""]], //gl rifle 9, mag, gl grenade, devices
["", "", ["", "", "", ""]], //mg 10, mag, devices
["", "", ["", "", "", ""]], //marksman rifle 11, mag, devices
"", //at singleshot 12
["", "", ["", "", "", ""]], //at reloadable 13, mag, devices
["", ""], //aa 14, mag
["rhs_mag_rgd5", "rhs_mag_rdg2_white"], //grenades array 15
["", "", ["", "", "", ""]], //sl handgun 16, mag, devices
"" //binoculars 17
];

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
