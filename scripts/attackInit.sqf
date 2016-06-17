if (!isServer) exitWith {};

//[getMarkerPos "SPAWNMARKERNAME", "BLUFOR", WEST] call mf_fnc_SpawnGroup;
mf_fnc_SpawnGroup = {
	params ["_pos", "_faction", "_side"];
	private ["_soldierArray","_randomGroupLeader","_spawnPos","_grp","_groupLeader","_randomGroupMember","_groupMember"];

	switch (_faction) do
	{
	case "BLUFOR": { _soldierArray = ["B_crew_F","B_Helipilot_F","B_Soldier_SL_F","B_soldier_AR_F","B_soldier_exp_F","B_soldier_GL_F","B_soldier_AA_F","B_soldier_M_F","B_medic_F","B_soldier_repair_F","B_Soldier_F","B_soldier_LAT_F","B_soldier_lite_F","B_soldier_TL_F"] };
	case "OPFOR": { _soldierArray = ["O_crew_F","O_Helipilot_F","O_Soldier_SL_F","O_soldier_AR_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_M_F","O_medic_F","O_soldier_AA_F","O_soldier_repair_F","O_Soldier_F","O_soldier_LAT_F","O_soldier_lite_F","O_soldier_TL_F"] };
	case "GUER": { _soldierArray = ["I_crew_F","I_Helipilot_F","I_Soldier_SL_F","I_soldier_AR_F","I_soldier_exp_F","I_soldier_GL_F","I_soldier_AA_F","I_soldier_M_F","I_medic_F","I_soldier_repair_F","I_Soldier_F","I_soldier_LAT_F","I_soldier_lite_F","I_soldier_TL_F"] };
		default { hint "No Valid Side Set"; [] };
	};
	
	_attackGroup = [];

	_randomGroupLeader = _soldierArray call BIS_fnc_selectrandom;
	_spawnPos = [_pos, 50 * sqrt random 1, random 360] call BIS_fnc_relPos;

	_grp = createGroup _side;
	_groupLeader = _grp createUnit [_randomGroupLeader, _spawnPos, [], 0, "FORM"];
	_groupLeader setRank "SERGEANT";
	_attackGroup pushBack _groupLeader;

	for "_i" from 0 to floor 6 do
	{
		_randomGroupMember = _soldierArray call BIS_fnc_selectrandom;
		_groupMember = _grp createUnit [_randomGroupMember, _spawnPos, [], 0, "FORM"];
		_attackGroup pushBack _groupMember;
	};

	{
		_x setSkill ["general", 0.8];
		_x setSkill ["aimingAccuracy", 0.15];
		_x setSkill ["aimingShake", 0.15];
		_x setSkill ["aimingSpeed", 0.15];
		_x setSkill ["endurance", 0.8];
		_x setSkill ["spotDistance", 0.3];
		_x setSkill ["spotTime", 0.3];
		_x setSkill ["courage", 0.8];
		_x setSkill ["reloadSpeed", 0.3];
		_x setSkill ["commanding", 0.8];
	} forEach (units group _groupLeader);
	
	_grp
};

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR", WEST] spawn mf_fnc_InfantryAttack;
mf_fnc_InfantryAttack = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	_grp = [_pos, _faction, _side] call mf_fnc_SpawnGroup;
	
	[_grp, _attackPos, 50] call CBA_fnc_taskAttack;
};

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR", WEST] spawn mf_fnc_InfantryDefend;
mf_fnc_InfantryDefend = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	_grp = [_pos, _faction, _side] call mf_fnc_SpawnGroup;
	
	[_grp, _attackPos, 50] call CBA_fnc_taskDefend;
};

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR", WEST] spawn mf_fnc_InfantryPartol;
mf_fnc_InfantryPartol = {
	params ["_pos", "_attackPos", "_faction", "_side"];
	
	_grp = [_pos, _faction, _side] call mf_fnc_SpawnGroup;
	
	[_grp, _attackPos, 200, 5] call CBA_fnc_taskPatrol;
};

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR", "BLUFOR Car", WEST] spawn mf_fnc_VehicleAttack;
mf_fnc_VehicleAttack = {
	params ["_pos", "_attackPos", "_faction", "_vehicle", "_side"];
	private ["_soldierArray","_vehicleArray","_spawnPos","_randomUnit","_randomVehicle","_grp","_veh","_vehicleCommander","_vehicleDriver","_vehicleGunner","_wp"];

	switch (_faction) do
	{
	case "BLUFOR": { _soldierArray = ["B_crew_F"] };
	case "OPFOR": { _soldierArray = ["O_crew_F"] };
	case "GUER": { _soldierArray = ["I_crew_F"] };
		default { hint "No Valid Side Set"; [] };
	};

	_vehicleArray = switch (_vehicle) do
	{
	case "BLUFOR Car": { ["B_MRAP_01_F"] };
	case "BLUFOR Armor": { ["B_APC_Wheeled_01_cannon_F"] };
	case "OPFOR Car": { ["O_MRAP_02_F"] };
	case "OPFOR Armor": { ["O_APC_Wheeled_02_rcws_F"] };
	case "GUER Car": { ["I_MRAP_03_F"] };
	case "GUER Armor": { ["I_APC_Wheeled_03_cannon_F"] };
		default { hint "No Valid Vehicle Set"; [] };
	};
	
	_attackGroup = [];

	_spawnPos = [_pos, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
	_randomUnit = _soldierArray call BIS_fnc_selectrandom;
	_randomVehicle = _vehicleArray call BIS_fnc_selectrandom;

	_grp = createGroup _side;
	_veh = _randomVehicle createVehicle _spawnPos;
	
	if (_veh emptyPositions "driver" > 0) then
	{
		_vehicleDriver = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
		_vehicleDriver setRank "CORPORAL";
		_vehicleDriver moveInDriver _veh;
		_attackGroup pushBack _vehicleDriver;
	};

	if (_veh emptyPositions "commander" > 0) then
	{
		_vehicleCommander = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
		_vehicleCommander setRank "SERGEANT";
		_vehicleCommander moveInCommander _veh;
		_attackGroup pushBack _vehicleCommander;
	};

	if (_veh emptyPositions "gunner" > 0) then
	{
		_vehicleGunner = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
		_vehicleGunner setRank "PRIVATE";
		_vehicleGunner moveInGunner _veh;
		_attackGroup pushBack _vehicleGunner;
	};

	{
		_vehicleCrew = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
		_vehicleCrew setRank "PRIVATE";
		_vehicleCrew moveInTurret [_veh, (_x select 3)];
		_attackGroup pushBack _vehicleCrew;
	} foreach (fullCrew [_veh, "turret", true]);

	{
		_vehicleCrew = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
		_vehicleCrew setRank "PRIVATE";
		_vehicleCrew moveInCargo [_veh, (_x select 2)];
		_attackGroup pushBack _vehicleCrew;
	} foreach (fullCrew [_veh, "cargo", true]);

	{
		_x setSkill ["general", 0.8];
		_x setSkill ["aimingAccuracy", 0.15];
		_x setSkill ["aimingShake", 0.15];
		_x setSkill ["aimingSpeed", 0.15];
		_x setSkill ["endurance", 0.8];
		_x setSkill ["spotDistance", 0.3];
		_x setSkill ["spotTime", 0.3];
		_x setSkill ["courage", 0.8];
		_x setSkill ["reloadSpeed", 0.3];
		_x setSkill ["commanding", 0.8];
	} forEach (units group _vehicleDriver);
	
	[_grp, _attackPos, 50, "UNLOAD", "AWARE", "RED", "LIMITED"] call CBA_fnc_addWaypoint;
};

//[getMarkerPos "SPAWNMARKERNAME", getMarkerPos "ATTACKMARKERNAME", "BLUFOR", "BLUFOR Air", WEST] spawn mf_fnc_AirAttack;
mf_fnc_AirAttack = {
	params ["_pos", "_attackPos", "_faction", "_vehicle", "_side"];
	private ["_soldierArray","_vehicleArray","_spawnPos","_randomVehicle","_grp","_veh","_vehicleCommander","_vehicleDriver","_vehicleGunner","_wp"];

	switch (_faction) do
	{
	case "BLUFOR": { _soldierArray = ["B_Helipilot_F","B_Soldier_F"] };
	case "OPFOR": { _soldierArray = ["O_Helipilot_F","O_Soldier_F"] };
	case "GUER": { _soldierArray = ["I_Helipilot_F","I_Soldier_F"] };
		default { hint "No Valid Side Set"; [] };
	};

	_vehicleArray = switch (_vehicle) do
	{
	case "BLUFOR Air": { ["B_Heli_Transport_01_F"] };
	case "OPFOR Air": { ["O_Heli_Light_02_F"] };
	case "GUER Air": { ["I_Heli_light_03_F"] };
		default { hint "No Valid Vehicle Set"; [] };
	};
	
	_attackGroup = [];
	
	_spawnPos = [_pos, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
	_pilotUnit = _soldierArray select 0;
	_crewUnit = _soldierArray select 1;
	_randomVehicle = _vehicleArray call BIS_fnc_selectrandom;

	_grp = createGroup _side;
	_grpParatroops = createGroup _side;
	_veh = createVehicle [_randomVehicle, _spawnPos, [], 0, "FLY"];
	
	if (_veh emptyPositions "driver" > 0) then
	{
		_vehicleDriver = _grp createUnit [_pilotUnit, [0,0,0], [], 0, "FORM"];
		_vehicleDriver setRank "CORPORAL";
		_vehicleDriver moveInDriver _veh;
		_attackGroup pushBack _vehicleDriver;
	};

	if (_veh emptyPositions "commander" > 0) then
	{
		_vehicleCommander = _grp createUnit [_crewUnit, [0,0,0], [], 0, "FORM"];
		_vehicleCommander setRank "SERGEANT";
		_vehicleCommander moveInCommander _veh;
		_attackGroup pushBack _vehicleCommander;
	};

	if (_veh emptyPositions "gunner" > 0) then
	{
		_vehicleGunner = _grp createUnit [_crewUnit, [0,0,0], [], 0, "FORM"];
		_vehicleGunner setRank "PRIVATE";
		_vehicleGunner moveInGunner _veh;
		_attackGroup pushBack _vehicleGunner;
	};

	{
		_vehicleCrew = _grp createUnit [_crewUnit, [0,0,0], [], 0, "FORM"];
		_vehicleCrew setRank "PRIVATE";
		_vehicleCrew moveInTurret [_veh, (_x select 3)];
		_attackGroup pushBack _vehicleCrew;
	} foreach (fullCrew [_veh, "turret", true]);
	
	{
		_vehicleCrew = _grp createUnit [_crewUnit, [0,0,0], [], 0, "FORM"];
		_vehicleCrew setRank "PRIVATE";
		_vehicleCrew moveInCargo [_veh, (_x select 2)];
		_attackGroup pushBack _vehicleCrew;
	} foreach (fullCrew [_veh, "cargo", true]);
	
	{
		removeBackpack _x;
		_x addBackpack "B_Parachute";
	} foreach (units group _vehicleDriver);

	{
		_x setSkill ["general", 0.8];
		_x setSkill ["aimingAccuracy", 0.15];
		_x setSkill ["aimingShake", 0.15];
		_x setSkill ["aimingSpeed", 0.15];
		_x setSkill ["endurance", 0.8];
		_x setSkill ["spotDistance", 0.3];
		_x setSkill ["spotTime", 0.3];
		_x setSkill ["courage", 0.8];
		_x setSkill ["reloadSpeed", 0.3];
		_x setSkill ["commanding", 0.8];
	} forEach (units group _vehicleDriver);

	_veh flyInHeight 200;
	
	[_grp, _attackPos, 50] call CBA_fnc_taskAttack;
	
	waitUntil {
		_veh distance2d _attackPos < 400 or !(canMove _veh)
	};
	
	{
		_unit = _x select 0;
		
		if (alive _unit) then {
			unassignVehicle _unit;
			moveOut _unit;
			[_unit] joinSilent _grpParatroops;
			sleep 0.7;
		};
	} foreach (fullCrew [_veh, "cargo"]);
	
	[_grpParatroops, _attackPos, 50] call CBA_fnc_taskAttack;
};

//[getMarkerPos "SPAWNMARKERNAME", 30, 1, 300, "Sh_82mm_AMOS"] spawn mf_fnc_MortarAttack;
mf_fnc_MortarAttack = {
	params ["_pos", "_number", "_sleep", "_radius", "_round"];

	for "_i" from 0 to floor _number do
	{
		_psn = [_pos, _radius * sqrt random 1, random 360] call BIS_fnc_relPos;
		_psn set [2, (_psn select 2) + 100];
		_mortar = createVehicle [_round, [0,0,0], [], 0, "FLY"];
		_mortar setPos _psn;
		_mortar setVelocity [0,0,-15];
		sleep _sleep;
	};
};
