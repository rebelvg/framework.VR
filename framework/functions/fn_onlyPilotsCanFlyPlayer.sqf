if (!isMultiplayer) exitWith {};

if (isNil "mf_onlyPilotsCanFly") exitWith {};

if (!mf_onlyPilotsCanFly) exitWith {};

player addEventHandler ["GetInMan", {
	params ["_unit", "_position", "_veh"];
	_className = toLower getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
	
	if (_className == "pilot") exitWith {};
	
	if (!([_unit] call mf_fnc_isUnitPilot)) exitWith {};
	
	if ((getPosATL _veh) select 2 > 5) exitWith {};

	unassignVehicle _unit;
	moveOut _unit;
	
	systemChat "Only pilots can fly.";
}];

player addEventHandler ["SeatSwitchedMan", {
	params ["_unit", "_unit2", "_veh"];
	_className = toLower getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
	
	if (_className == "pilot") exitWith {};
	
	if (!([_unit] call mf_fnc_isUnitPilot)) exitWith {};
	
	if ((getPosATL _veh) select 2 > 5) exitWith {};

	unassignVehicle _unit;
	moveOut _unit;
	
	systemChat "Can change sits only when flying.";
}];
