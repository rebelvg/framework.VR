//this is a preInit settings file, do not add any code here, only edit the functions available
//do not remove the file

/*
list of functions

//Infantry
_grp = [getMarkerPos "mission_spawn", "EAST", _unitCount, _skill] call kf_fnc_ai_createGroup;
[_grp, getMarkerPos "mission_attack", _radius] call kf_fnc_ai_infantryAttack;
[_grp, getMarkerPos "mission_attack", _radius] call kf_fnc_ai_infantryDefend;
[_grp, getMarkerPos "mission_attack", _radius, _wpCount] call kf_fnc_ai_infantryPatrol;

_grp = [getMarkerPos "mission_spawn", "EAST", _radius, _unitCount, _skill, _threshold, ["DOWN", "MIDDLE", "UP", "AUTO"]] call kf_fnc_ai_infantryBunker;

//Vehicles
_veh = [getMarkerPos "mission_spawn", "EAST Crew", "EAST Car", _skill] call kf_fnc_ai_createVehicleGroup;
[_veh, getMarkerPos "mission_attack", _radius] call kf_fnc_ai_vehicleAttack;

//Air Vehicles
_veh = [getMarkerPos "mission_spawn", "EAST Crew", "EAST Air", _skill, _flyHeight] call kf_fnc_ai_createAirVehicleGroup;
[_veh, getMarkerPos "mission_attack", _radius, _wpCount] call kf_fnc_ai_airPatrol;

//Mortars
[getMarkerPos "mission_spawn", _roundCount, _interval, _radius, "Sh_82mm_AMOS", _height] call kf_fnc_ai_mortarAttack;
*/
