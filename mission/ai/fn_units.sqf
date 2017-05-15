//this is a preInit settings file, do not add any code here, only edit the functions available
//do not remove the file

/*
list of functions

_grp = [getMarkerPos "mission_spawn", "EAST", _unitCount, _skill] call mf_fnc_ai_createGroup;
[_grp, getMarkerPos "mission_attack", _radius] call kf_fnc_ai_infantryAttack;
[_grp, getMarkerPos "mission_attack", _radius] call kf_fnc_ai_infantryDefend;
[_grp, getMarkerPos "mission_attack", _radius, _wpCount] call kf_fnc_ai_infantryPatrol;
_grp = [getMarkerPos "mission_spawn", "EAST", _radius, _unitCount, _skill, _threshold, ["DOWN", "MIDDLE", "UP", "AUTO"]] call kf_fnc_ai_infantryBunker;
_veh = [getMarkerPos "mission_spawn", "EAST Crew", "EAST Car", _skill] call kf_fnc_ai_createVehicleGroup;
[_veh, getMarkerPos "mission_attack", _radius] call kf_fnc_ai_vehicleAttack;
_veh = [getMarkerPos "mission_spawn", "EAST Crew", "EAST Air", _skill, _flyHeight] call kf_fnc_ai_createAirVehicleGroup;
[_veh, getMarkerPos "mission_attack", _radius, _wpCount] call kf_fnc_ai_airPatrol;
[getMarkerPos "mission_spawn", _roundCount, _interval, _radius, "Sh_82mm_AMOS", _height] call mf_fnc_ai_mortarAttack;
*/

mf_fnc_ai_soldierArray = {
    params ["_faction"];

    private _conf = missionConfigFile >> "KF_AI" >> "Units";

    private _soldierArray = switch (_faction) do
    {
    case "EAST": { getArray (_conf >> "EAST" >> "infantry") };
    case "EAST Crew": { getArray (_conf >> "EAST" >> "crew") };
    case "WEST": { getArray (_conf >> "WEST" >> "infantry") };
    case "WEST Crew": { getArray (_conf >> "WEST" >> "crew") };
    case "GUER": { getArray (_conf >> "GUER" >> "infantry") };
    case "GUER Crew": { getArray (_conf >> "GUER" >> "crew") };
        default { [] };
    };

    _soldierArray
};

mf_fnc_ai_vehicleArray = {
    params ["_vehicle"];

    private _conf = missionConfigFile >> "KF_AI" >> "Units";

    private _vehicleArray = switch (_vehicle) do
    {
    case "EAST Car": { getArray (_conf >> "EAST" >> "wheeled") };
    case "EAST Armor": { getArray (_conf >> "EAST" >> "armored") };
    case "EAST Air": { getArray (_conf >> "EAST" >> "air") };
    case "WEST Car": { getArray (_conf >> "WEST" >> "wheeled") };
    case "WEST Armor": { getArray (_conf >> "WEST" >> "armored") };
    case "WEST Air": { getArray (_conf >> "WEST" >> "air") };
    case "GUER Car": { getArray (_conf >> "GUER" >> "wheeled") };
    case "GUER Armor": { getArray (_conf >> "GUER" >> "armored") };
    case "GUER Air": { getArray (_conf >> "GUER" >> "air") };
        default { [] };
    };

    _vehicleArray
};
