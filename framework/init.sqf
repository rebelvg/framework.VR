radioNetArray = [["101", "102", "103", "104", "105", "106", "107", "108"], ["111", "112", "113", "114", "115", "116", "117", "118"], ["121", "122", "123", "124", "125", "126", "127", "128"], ["131", "132", "133", "134", "135", "136", "137", "138"], ["141", "142", "143", "144", "145", "146", "147", "148"], ["151", "152", "153", "154", "155", "156", "157", "158"], ["161", "162", "163", "164", "165", "166", "167", "168"], ["171", "172", "173", "174", "175", "176", "177", "178"]];

debugLoadout_fnc = {
{
[_x] execVM "scripts\loadout.sqf";
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
_x disableAI "ANIM";
};
} foreach switchableUnits;
[] spawn debugLoadout_fnc;
};

if (!isNil "ZE_Zeus") then {
if (!isMultiplayer) then {
[] execVM "zes.sqf";
} else {
deleteVehicle ZE_Zeus;
};
};
