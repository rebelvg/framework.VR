if (!isMultiplayer) exitWith {};

if (!mf_onlyPilotsCanFly) exitWith {};

_className = toLower getText (configFile >> "CfgVehicles" >> typeOf player >> "displayName");

if (_className == "pilot") exitWith {};

player addEventHandler ["GetInMan", {
	params ["_unit", "_position", "_veh"];
	
	if (!([_unit] call mf_fnc_isUnitPilot)) exitWith {};
	
	if ((getPosATL _veh) select 2 > 3) exitWith {};

	unassignVehicle _unit;
	moveOut _unit;
	
	systemChat "Only pilots can fly.";
}];

player addEventHandler ["SeatSwitchedMan", {
	params ["_unit", "_unit2", "_veh"];
	
	if (!([_unit] call mf_fnc_isUnitPilot)) exitWith {};
	
	if ((getPosATL _veh) select 2 > 3) exitWith {};

	unassignVehicle _unit;
	moveOut _unit;
	
	systemChat "Can change sits only when flying.";
}];
