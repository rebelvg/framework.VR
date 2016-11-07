if (isNil "mf_fnc_ai_soldierArray") then {
    mf_fnc_ai_soldierArray = {
        []
    };
};

if (isNil "mf_fnc_ai_vehicleArray") then {
    mf_fnc_ai_vehicleArray = {
        []
    };
};

mf_fnc_ai_getSide = {
    params ["_unit"];

    _sideNumber = getNumber (configFile >> "CfgVehicles" >> _unit >> "side");

    switch (_sideNumber) do {
    case 0: {
            _side = EAST;
        };
    case 1: {
            _side = WEST;
        };
    case 2: {
            _side = RESISTANCE;
        };
    case 3: {
            _side = CIVILIAN;
        };
        default {
            _side = CIVILIAN;
        };
    };

    _side
};

mf_fnc_ai_applySkill = {
    params ["_grp"];

    {
        _x setSkill ["aimingAccuracy", 0.5];
        _x setSkill ["aimingShake", 0.5];
        _x setSkill ["aimingSpeed", 0.5];
        _x setSkill ["endurance", 0.7];
        _x setSkill ["spotDistance", 0.7];
        _x setSkill ["spotTime", 0.7];
        _x setSkill ["courage", 0.7];
        _x setSkill ["reloadSpeed", 0.7];
        _x setSkill ["commanding", 0.7];
        _x setSkill ["general", 0.7];
    } forEach (units _grp);

    _grp allowFleeing 0;
};

mf_fnc_ai_createGroup = {
    params ["_pos", "_faction"];
    private ["_soldierArray","_spawnPos","_grp","_groupLeader","_groupMember","_side"];

    _soldierArray = [_faction] call mf_fnc_ai_soldierArray;

    if (count _soldierArray == 0) exitWith {};

    _spawnPos = [_pos, 50 * sqrt random 1, random 360] call BIS_fnc_relPos;

    _side = [_soldierArray select 0] call mf_fnc_ai_getSide;

    _grp = createGroup _side;
    _groupLeader = _grp createUnit [_soldierArray select 0, _spawnPos, [], 0, "FORM"];

    for "_i" from 0 to floor 6 do
    {
        _groupMember = _grp createUnit [selectRandom _soldierArray, _spawnPos, [], 0, "FORM"];
    };

    [_grp] call mf_fnc_ai_applySkill;

    _grp
};

mf_fnc_ai_createCrew = {
    params ["_grp", "_veh", "_driver", "_crew"];

    if (_veh emptyPositions "driver" > 0) then
    {
        _vehicleDriver = _grp createUnit [_driver, [0,0,0], [], 0, "FORM"];
        _vehicleDriver moveInDriver _veh;
    };

    if (_veh emptyPositions "commander" > 0) then
    {
        _vehicleCommander = _grp createUnit [_crew, [0,0,0], [], 0, "FORM"];
        _vehicleCommander moveInCommander _veh;
    };

    if (_veh emptyPositions "gunner" > 0) then
    {
        _vehicleGunner = _grp createUnit [_crew, [0,0,0], [], 0, "FORM"];
        _vehicleGunner moveInGunner _veh;
    };

    {
        _vehicleCrew = _grp createUnit [_crew, [0,0,0], [], 0, "FORM"];
        _vehicleCrew moveInTurret [_veh, (_x select 3)];
    } foreach (fullCrew [_veh, "turret", true]);
};

mf_fnc_ai_infantryAttack = {
    params ["_pos", "_attackPos", "_faction"];

    if (!isServer) exitWith {};

    _grp = [_pos, _faction] call mf_fnc_ai_createGroup;

    [_grp, _attackPos, 50, "SAD", "AWARE", "YELLOW"] call CBA_fnc_addWaypoint;

    _grp
};

mf_fnc_ai_infantryDefend = {
    params ["_pos", "_attackPos", "_faction"];

    if (!isServer) exitWith {};

    _grp = [_pos, _faction] call mf_fnc_ai_createGroup;

    [_grp, _attackPos, 50] call CBA_fnc_taskDefend;

    _grp
};

mf_fnc_ai_infantryPatrol = {
    params ["_pos", "_attackPos", "_faction"];

    if (!isServer) exitWith {};

    _grp = [_pos, _faction] call mf_fnc_ai_createGroup;

    [_grp, _attackPos, 100, 5, "SAD"] call CBA_fnc_taskPatrol;

    _grp
};

mf_fnc_ai_vehicleAttack = {
    params ["_pos", "_attackPos", "_faction", "_vehicle"];
    private ["_soldierArray","_vehicleArray","_spawnPos","_grp","_veh","_side"];

    if (!isServer) exitWith {};

    _soldierArray = [_faction] call mf_fnc_ai_soldierArray;

    if (count _soldierArray < 1) exitWith {};

    _vehicleArray = [_vehicle] call mf_fnc_ai_vehicleArray;

    if (count _vehicleArray == 0) exitWith {};

    _spawnPos = [_pos, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
    _veh = (selectRandom _vehicleArray) createVehicle _spawnPos;

    _side = [_soldierArray select 0] call mf_fnc_ai_getSide;

    _grp = createGroup _side;
    [_grp, _veh, _soldierArray select 0, _soldierArray select 0] call mf_fnc_ai_createCrew;
    [_grp] call mf_fnc_ai_applySkill;

    [_grp, _attackPos, 100, "SAD", "AWARE", "YELLOW"] call CBA_fnc_addWaypoint;

    _grp
};

mf_fnc_ai_airPatrol = {
    params ["_pos", "_attackPos", "_faction", "_vehicle"];
    private ["_soldierArray","_vehicleArray","_spawnPos","_grp","_veh","_side"];

    if (!isServer) exitWith {};

    _soldierArray = [_faction] call mf_fnc_ai_soldierArray;

    if (count _soldierArray < 2) exitWith {};

    _vehicleArray = [_vehicle] call mf_fnc_ai_vehicleArray;

    if (count _vehicleArray == 0) exitWith {};

    _spawnPos = [_pos, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
    _veh = createVehicle [selectRandom _vehicleArray, _spawnPos, [], 0, "FLY"];

    _side = [_soldierArray select 1] call mf_fnc_ai_getSide;

    _grp = createGroup _side;
    [_grp, _veh, _soldierArray select 1, _soldierArray select 1] call mf_fnc_ai_createCrew;
    [_grp] call mf_fnc_ai_applySkill;

    [_grp, _attackPos, 300, 5, "SAD"] call CBA_fnc_taskPatrol;

    _grp
};

mf_fnc_ai_mortarAttack = {
    params ["_pos", "_number", "_interval", "_radius", "_round"];

    if (!isServer) exitWith {};

    for "_i" from 0 to floor _number do
    {
        _psn = [_pos, _radius * sqrt random 1, random 360] call BIS_fnc_relPos;
        _psn set [2, (_psn select 2) + 200];
        _mortar = createVehicle [_round, [0,0,0], [], 0, "FLY"];
        _mortar setPos _psn;
        _mortar setVelocity [0,0,-15];
        sleep _interval;
    };
};
