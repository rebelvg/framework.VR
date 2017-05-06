//this is a preInit settings file, do not add any code here, only edit the functions available
//do not remove the file

/*
list of functions

[getMarkerPos "mission_spawn", "EAST", _count] call mf_fnc_ai_createGroup;
[getMarkerPos "mission_spawn", getMarkerPos "mission_attack", "EAST", _count] call mf_fnc_ai_infantryAttack;
[getMarkerPos "mission_spawn", getMarkerPos "mission_attack", "EAST", _radius, _count] call mf_fnc_ai_infantryDefend;
[getMarkerPos "mission_spawn", getMarkerPos "mission_attack", "EAST", _radius, _count] call mf_fnc_ai_infantryPatrol;
[getMarkerPos "mission_spawn", "EAST", _radius, _count] call kf_fnc_ai_infantryBunker;
[getMarkerPos "mission_spawn", getMarkerPos "mission_attack", "EAST Crew", "EAST Car"] call mf_fnc_ai_vehicleAttack;
[getMarkerPos "mission_spawn", getMarkerPos "mission_attack", "EAST Crew", "EAST Air", _radius] call mf_fnc_ai_airPatrol;
[getMarkerPos "mission_spawn", _count, _interval, _radius, "Sh_82mm_AMOS"] call mf_fnc_ai_mortarAttack;
*/

mf_fnc_ai_soldierArray = {
    params ["_faction"];

    _soldierArray = switch (_faction) do
    {
        //"sl", "all other units", minimum 2 units
    case "EAST": { ["O_Soldier_SL_F","O_medic_F","O_engineer_F","O_soldier_TL_F","O_Soldier_AT_F","O_soldier_AA_F","O_soldier_AR_F","O_soldier_LAT_F","O_soldier_GL_F","O_soldier_M_F","O_Soldier_F"] };
        //"crew", "pilot", should be 2 units
    case "EAST Crew": { ["O_crew_F","O_Helipilot_F"] };
    case "WEST": { ["B_Soldier_SL_F","B_medic_F","B_engineer_F","B_soldier_TL_F","B_soldier_AT_F","B_soldier_AA_F","B_soldier_AR_F","B_soldier_LAT_F","B_soldier_GL_F","B_soldier_M_F","B_Soldier_F"] };
    case "WEST Crew": { ["B_crew_F","B_Helipilot_F"] };
    case "GUER": { ["I_Soldier_SL_F","I_medic_F","I_engineer_F","I_soldier_TL_F","I_Soldier_AT_F","I_soldier_AA_F","I_soldier_AR_F","I_soldier_LAT_F","I_soldier_GL_F","I_soldier_M_F","I_Soldier_F"] };
    case "GUER Crew": { ["I_crew_F","I_Helipilot_F"] };
        default { [] };
    };

    _soldierArray
};

mf_fnc_ai_vehicleArray = {
    params ["_vehicle"];

    _vehicleArray = switch (_vehicle) do
    {
    case "EAST Car": { ["O_MRAP_02_F"] };
    case "EAST Armor": { ["O_APC_Wheeled_02_rcws_F"] };
    case "EAST Air": { ["O_Heli_Light_02_F"] };
    case "WEST Car": { ["B_MRAP_01_F"] };
    case "WEST Armor": { ["B_APC_Wheeled_01_cannon_F"] };
    case "WEST Air": { ["B_Heli_Transport_01_F"] };
    case "GUER Car": { ["I_MRAP_03_F"] };
    case "GUER Armor": { ["I_APC_Wheeled_03_cannon_F"] };
    case "GUER Air": { ["I_Heli_light_03_F"] };
        default { [] };
    };

    _vehicleArray
};
