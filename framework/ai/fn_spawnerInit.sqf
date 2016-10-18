if (!isServer) exitWith {};

mf_fnc_ai_soldierArray = {
	params ["_faction"];

	_soldierArray = switch (_faction) do
	{
	case "BLUFOR": { ["B_Soldier_SL_F","B_soldier_AR_F","B_soldier_exp_F","B_soldier_GL_F","B_soldier_AA_F","B_soldier_M_F","B_medic_F","B_soldier_repair_F","B_Soldier_F","B_soldier_LAT_F","B_soldier_lite_F","B_soldier_TL_F"] };
	case "OPFOR": { ["O_Soldier_SL_F","O_soldier_AR_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_M_F","O_medic_F","O_soldier_AA_F","O_soldier_repair_F","O_Soldier_F","O_soldier_LAT_F","O_soldier_lite_F","O_soldier_TL_F"] };
	case "GUER": { ["I_Soldier_SL_F","I_soldier_AR_F","I_soldier_exp_F","I_soldier_GL_F","I_soldier_AA_F","I_soldier_M_F","I_medic_F","I_soldier_repair_F","I_Soldier_F","I_soldier_LAT_F","I_soldier_lite_F","I_soldier_TL_F"] };
	case "BLUFOR Crew": { ["B_crew_F","B_Helipilot_F"] };
	case "OPFOR Crew": { ["O_crew_F","O_Helipilot_F"] };
	case "GUER Crew": { ["I_crew_F","I_Helipilot_F"] };
		default { [] };
	};

	_soldierArray
};

mf_fnc_ai_vehicleArray = {
	params ["_vehicle"];

	_vehicleArray = switch (_vehicle) do
	{
	case "BLUFOR Car": { ["B_MRAP_01_F"] };
	case "BLUFOR Armor": { ["B_APC_Wheeled_01_cannon_F"] };
	case "BLUFOR Air": { ["B_Heli_Transport_01_F"] };
	case "OPFOR Car": { ["O_MRAP_02_F"] };
	case "OPFOR Armor": { ["O_APC_Wheeled_02_rcws_F"] };
	case "OPFOR Air": { ["O_Heli_Light_02_F"] };
	case "GUER Car": { ["I_MRAP_03_F"] };
	case "GUER Armor": { ["I_APC_Wheeled_03_cannon_F"] };
	case "GUER Air": { ["I_Heli_light_03_F"] };
		default { [] };
	};

	_vehicleArray
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

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR", WEST] call mf_fnc_ai_infantryAttack;
mf_fnc_ai_infantryAttack = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	_grp = [_pos, _faction, _side] call mf_fnc_ai_createGroup;
	
	[_grp, _attackPos, 50] call CBA_fnc_taskAttack;
	
	units _grp
};

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR", WEST] call mf_fnc_ai_infantryDefend;
mf_fnc_ai_infantryDefend = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	_grp = [_pos, _faction, _side] call mf_fnc_ai_createGroup;
	
	[_grp, _attackPos, 50] call CBA_fnc_taskDefend;
	
	units _grp
};

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR", WEST] call mf_fnc_ai_infantryPatrol;
mf_fnc_ai_infantryPatrol = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	_grp = [_pos, _faction, _side] call mf_fnc_ai_createGroup;
	
	[_grp, _attackPos, 100, 5] call CBA_fnc_taskPatrol;
	
	units _grp
};

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR Crew", "BLUFOR Car", WEST] call mf_fnc_ai_vehicleAttack;
mf_fnc_ai_vehicleAttack = {
	params ["_pos", "_attackPos", "_faction", "_vehicle", "_side"];
	private ["_soldierArray","_vehicleArray","_spawnPos","_grp","_veh"];
	
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

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR Crew", "BLUFOR Air", WEST] call mf_fnc_ai_airAttack;
mf_fnc_ai_airAttack = {
	params ["_pos", "_attackPos", "_faction", "_vehicle", "_side"];
	private ["_soldierArray","_vehicleArray","_spawnPos","_grp","_veh"];

	_soldierArray = [_faction] call mf_fnc_ai_soldierArray;
	
	if (count _soldierArray < 2) exitWith {};

	_vehicleArray = [_vehicle] call mf_fnc_ai_vehicleArray;
	
	if (count _vehicleArray == 0) exitWith {};
	
	_spawnPos = [_pos, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
	_veh = createVehicle [selectRandom _vehicleArray, _spawnPos, [], 0, "FLY"];

	_grp = createGroup _side;
	[_grp, _veh, _soldierArray select 1, _soldierArray select 0] call mf_fnc_ai_createCrew;
	[_grp] call mf_fnc_ai_applySkill;
	
	[_grp, _attackPos, 300, 5] call CBA_fnc_taskPatrol;
	
	units _grp
};

//[getMarkerPos "SPAWNMARKERNAME", 30, 1, 300, "Sh_82mm_AMOS"] spawn mf_fnc_ai_mortarAttack;
mf_fnc_ai_mortarAttack = {
	params ["_pos", "_number", "_interval", "_radius", "_round"];

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
