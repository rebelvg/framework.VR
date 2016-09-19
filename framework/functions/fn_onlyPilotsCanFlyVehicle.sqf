params ["_vehicle"];

if (!isMultiplayer) exitWith {};

if (isNil "mf_onlyPilotsCanFly") exitWith {};

if (!mf_onlyPilotsCanFly) exitWith {};

if (!(_vehicle isKindOf "air")) exitWith {};

_vehicle addEventHandler ["ControlsShifted", {
	params ["_veh", "_unit"];			
	_className = toLower getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
	
	if (_className == "pilot") exitWith {};
	
	if ((getPosATL _veh) select 2 > 5) exitWith {};

	[[[_veh, _unit], {
		params ["_veh", "_unit"];
		
		_unit action ["SuspendVehicleControl", _veh];
		systemChat "Can take controls only when flying.";
	}], "BIS_fnc_spawn", _unit] call BIS_fnc_MP;
}];
