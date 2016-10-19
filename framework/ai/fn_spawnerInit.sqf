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

mf_fnc_ai_applySkill = {
	params ["_grp"];
	
	{
		_x setSkill ["aimingAccuracy", 0.2];
		_x setSkill ["aimingShake", 0.2];
		_x setSkill ["aimingSpeed", 0.2];
		_x setSkill ["endurance", 0.8];
		_x setSkill ["spotDistance", 0.4];
		_x setSkill ["spotTime", 0.4];
		_x setSkill ["courage", 0.8];
		_x setSkill ["reloadSpeed", 0.4];
		_x setSkill ["commanding", 0.8];
		_x setSkill ["general", 0.8];
	} forEach (units _grp);
};

mf_fnc_ai_createGroup = {
	params ["_pos", "_faction", "_side"];
	private ["_soldierArray","_spawnPos","_grp","_groupLeader","_groupMember"];

	_soldierArray = [_faction] call mf_fnc_ai_soldierArray;
	
	if (count _soldierArray == 0) exitWith {};

	_spawnPos = [_pos, 50 * sqrt random 1, random 360] call BIS_fnc_relPos;

	_grp = createGroup _side;
	_groupLeader = _grp createUnit [_soldierArray select 0, _spawnPos, [], 0, "FORM"];
	_groupLeader setRank "SERGEANT";

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
		_vehicleDriver setRank "CORPORAL";
		_vehicleDriver moveInDriver _veh;
	};

	if (_veh emptyPositions "commander" > 0) then
	{
		_vehicleCommander = _grp createUnit [_crew, [0,0,0], [], 0, "FORM"];
		_vehicleCommander setRank "SERGEANT";
		_vehicleCommander moveInCommander _veh;
	};

	if (_veh emptyPositions "gunner" > 0) then
	{
		_vehicleGunner = _grp createUnit [_crew, [0,0,0], [], 0, "FORM"];
		_vehicleGunner setRank "PRIVATE";
		_vehicleGunner moveInGunner _veh;
	};

	{
		_vehicleCrew = _grp createUnit [_crew, [0,0,0], [], 0, "FORM"];
		_vehicleCrew setRank "PRIVATE";
		_vehicleCrew moveInTurret [_veh, (_x select 3)];
	} foreach (fullCrew [_veh, "turret", true]);
};

mf_fnc_ai_infantryAttack = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	if (!isServer) exitWith {};
	
	_grp = [_pos, _faction, _side] call mf_fnc_ai_createGroup;
	
	[_grp, _attackPos, 50] call CBA_fnc_taskAttack;
	
	units _grp
};

mf_fnc_ai_infantryDefend = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	if (!isServer) exitWith {};
	
	_grp = [_pos, _faction, _side] call mf_fnc_ai_createGroup;
	
	[_grp, _attackPos, 50] call CBA_fnc_taskDefend;
	
	units _grp
};

mf_fnc_ai_infantryPatrol = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	if (!isServer) exitWith {};
	
	_grp = [_pos, _faction, _side] call mf_fnc_ai_createGroup;
	
	[_grp, _attackPos, 100, 5] call CBA_fnc_taskPatrol;
	
	units _grp
};

mf_fnc_ai_vehicleAttack = {
	params ["_pos", "_attackPos", "_faction", "_vehicle", "_side"];
	private ["_soldierArray","_vehicleArray","_spawnPos","_grp","_veh"];
	
	if (!isServer) exitWith {};
	
	_soldierArray = [_faction] call mf_fnc_ai_soldierArray;
	
	if (count _soldierArray < 1) exitWith {};

	_vehicleArray = [_vehicle] call mf_fnc_ai_vehicleArray;
	
	if (count _vehicleArray == 0) exitWith {};

	_spawnPos = [_pos, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
	_veh = (selectRandom _vehicleArray) createVehicle _spawnPos;
	
	_grp = createGroup _side;
	[_grp, _veh, _soldierArray select 0, _soldierArray select 0] call mf_fnc_ai_createCrew;
	[_grp] call mf_fnc_ai_applySkill;
	
	[_grp, _attackPos, 100] call CBA_fnc_taskAttack;
	
	units _grp
};

mf_fnc_ai_airPatrol = {
	params ["_pos", "_attackPos", "_faction", "_vehicle", "_side"];
	private ["_soldierArray","_vehicleArray","_spawnPos","_grp","_veh"];
	
	if (!isServer) exitWith {};

	_soldierArray = [_faction] call mf_fnc_ai_soldierArray;
	
	if (count _soldierArray < 2) exitWith {};

	_vehicleArray = [_vehicle] call mf_fnc_ai_vehicleArray;
	
	if (count _vehicleArray == 0) exitWith {};
	
	_spawnPos = [_pos, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
	_veh = createVehicle [selectRandom _vehicleArray, _spawnPos, [], 0, "FLY"];

	_grp = createGroup _side;
	[_grp, _veh, _soldierArray select 1, _soldierArray select 1] call mf_fnc_ai_createCrew;
	[_grp] call mf_fnc_ai_applySkill;
	
	[_grp, _attackPos, 300, 5, "SAD"] call CBA_fnc_taskPatrol;
	
	units _grp
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
