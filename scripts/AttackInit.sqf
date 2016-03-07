if (!isServer) exitWith {};

//["SPAWNMARKERNAME", "ATTACKMARKERNAME", "BLUFOR", WEST, 0] spawn fnc_InfantryAttack;
fnc_InfantryAttack = {
	private ["_marker","_attackMarker","_faction","_side","_times","_soldierArray","_randomGroupLeader","_spawnMarker","_grp","_groupLeader","_randomGroupMember","_groupMember","_wp","_formations","_chosenFormations"];
	_marker = _this select 0;
	_attackMarker = _this select 1;
	_faction = _this select 2;
	_side = _this select 3;
	_times = _this select 4;

	switch (_faction) do
	{
	case "BLUFOR": { _soldierArray = ["B_crew_F","B_Helipilot_F","B_Soldier_SL_F","B_soldier_AR_F","B_soldier_AR_F","B_soldier_exp_F","B_soldier_GL_F","B_soldier_GL_F","B_soldier_AA_F","B_soldier_M_F","B_medic_F","B_soldier_repair_F","B_Soldier_F","B_Soldier_F","B_soldier_LAT_F","B_soldier_LAT_F","B_soldier_lite_F","B_soldier_TL_F","B_soldier_TL_F"] };
	case "OPFOR": { _soldierArray = ["O_crew_F","O_Helipilot_F","O_Soldier_SL_F","O_soldier_AR_F","O_soldier_AR_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_GL_F","O_soldier_M_F","O_medic_F","O_soldier_AA_F","O_soldier_repair_F","O_Soldier_F","O_Soldier_F","O_soldier_LAT_F","O_soldier_LAT_F","O_soldier_lite_F","O_soldier_TL_F","O_soldier_TL_F"] };
	case "GUER": { _soldierArray = ["I_crew_F","I_Helipilot_F","I_Soldier_SL_F","I_soldier_AR_F","I_soldier_AR_F","I_soldier_exp_F","I_soldier_GL_F","I_soldier_GL_F","I_soldier_AA_F","I_soldier_M_F","I_medic_F","I_soldier_repair_F","I_Soldier_F","I_Soldier_F","I_soldier_LAT_F","I_soldier_LAT_F","I_soldier_lite_F","I_soldier_TL_F","I_soldier_TL_F"] };
		default { hint "No Valid Side Set"; [] };
	};

	for "_i" from 0 to floor _times do
	{
		_randomGroupLeader = _soldierArray call BIS_fnc_selectrandom;
		_spawnMarker = [getMarkerPos _marker, 50 * sqrt random 1, random 360] call BIS_fnc_relPos;

		_grp = createGroup _side;
		_groupLeader = _grp createUnit [_randomGroupLeader, _spawnMarker, [], 0, "FORM"];
		_groupLeader setRank "SERGEANT";
		attackGroup pushBack _groupLeader;

		for "_i" from 0 to floor 6 do
		{
			_randomGroupMember = _soldierArray call BIS_fnc_selectrandom;
			_groupMember = _grp createUnit [_randomGroupMember, _spawnMarker, [], 0, "FORM"];
			attackGroup pushBack _groupMember;
		};

		{
			_x setSkill ["general", 0.4];
			_x setSkill ["aimingAccuracy", 0.3];
			_x setSkill ["aimingShake", 0.3];
			_x setSkill ["aimingSpeed", 0.3];
			_x setSkill ["endurance", 0.4];
			_x setSkill ["spotDistance", 0.4];
			_x setSkill ["spotTime", 0.4];
			_x setSkill ["courage", 0.4];
			_x setSkill ["reloadSpeed", 0.4];
			_x setSkill ["commanding", 0.4];
		} forEach units group _groupLeader;

		_wp = _grp addWaypoint [getMarkerPos _attackMarker, 0];
		_wp setWaypointType "SAD";
		_grp setBehaviour "Aware";
		_grp setCombatMode "RED";
		_formations = ["COLUMN","STAG COLUMN","LINE","WEDGE"];
		_chosenFormations = _formations call BIS_fnc_selectrandom;
		_grp setFormation _chosenFormations;
	};
};

//["SPAWNMARKERNAME", "ATTACKMARKERNAME", "BLUFOR", "BLUFOR Car", WEST, 0] spawn fnc_VehicleAttack;
fnc_VehicleAttack = {
	private ["_marker","_attackMarker","_faction","_vehicle","_side","_times","_soldierArray","_vehicleArray","_spawnMarker","_randomUnit","_randomVehicle","_grp","_veh","_vehicleCommander","_vehicleDriver","_vehicleGunner","_wp","_formations","_chosenFormations"];	_marker = _this select 0;
	_marker = _this select 0;
	_attackMarker = _this select 1;
	_faction = _this select 2;
	_vehicle = _this select 3;
	_side = _this select 4;
	_times = _this select 5;

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
		default { hint "No Valid Vehicle Set"; };
	};

	for "_i" from 0 to floor _times do
	{
		_spawnMarker = [getMarkerPos _marker, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
		_randomUnit = _soldierArray call BIS_fnc_selectrandom;
		_randomVehicle = _vehicleArray call BIS_fnc_selectrandom;

		_grp = createGroup _side;
		_veh = _randomVehicle createVehicle _spawnMarker;

		if (_veh emptyPositions "commander" > 0) then
		{
			_vehicleCommander = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleCommander setRank "SERGEANT";
			_vehicleCommander moveInCommander _veh;
			attackGroup pushBack _vehicleCommander;
		};

		if (_veh emptyPositions "driver" > 0) then
		{
			_vehicleDriver = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleDriver setRank "CORPORAL";
			_vehicleDriver moveInDriver _veh;
			attackGroup pushBack _vehicleDriver;
		};

		if (_veh emptyPositions "gunner" > 0) then
		{
			_vehicleGunner = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleGunner setRank "PRIVATE";
			_vehicleGunner moveInGunner _veh;
			attackGroup pushBack _vehicleGunner;
		};

		{
			_x setSkill ["general", 0.4];
			_x setSkill ["aimingAccuracy", 0.3];
			_x setSkill ["aimingShake", 0.3];
			_x setSkill ["aimingSpeed", 0.3];
			_x setSkill ["endurance", 0.4];
			_x setSkill ["spotDistance", 0.4];
			_x setSkill ["spotTime", 0.4];
			_x setSkill ["courage", 0.4];
			_x setSkill ["reloadSpeed", 0.4];
			_x setSkill ["commanding", 0.4];
		} forEach units group _vehicleDriver;

		_wp = _grp addWaypoint [getMarkerPos _attackMarker, 0];
		_wp setWaypointType "SAD";
		_grp setBehaviour "COMBAT";
		_grp setCombatMode "RED";
		_formations = ["COLUMN","STAG COLUMN","LINE","WEDGE"];
		_chosenFormations = _formations call BIS_fnc_selectrandom;
		_grp setFormation _chosenFormations;
	};
};

//["SPAWNMARKERNAME", "ATTACKMARKERNAME", "BLUFOR", "BLUFOR Air", WEST, 0] spawn fnc_HeliAttack;
fnc_HeliAttack = {
	private ["_marker","_attackMarker","_faction","_vehicle","_side","_times","_soldierArray","_vehicleArray","_spawnMarker","_randomUnit","_randomVehicle","_grp","_veh","_vehicleCommander","_vehicleDriver","_vehicleGunner","_wp","_formations","_chosenFormations"];	_marker = _this select 0;
	_marker = _this select 0;
	_attackMarker = _this select 1;
	_faction = _this select 2;
	_vehicle = _this select 3;
	_side = _this select 4;
	_times = _this select 5;

	switch (_faction) do
	{
	case "BLUFOR": { _soldierArray = ["B_Helipilot_F"] };
	case "OPFOR": { _soldierArray = ["O_Helipilot_F"] };
	case "GUER": { _soldierArray = ["I_Helipilot_F"] };
		default { hint "No Valid Side Set"; [] };
	};

	_vehicleArray = switch (_vehicle) do
	{
	case "BLUFOR Air": { ["B_Heli_Transport_01_F"] };
	case "OPFOR Air": { ["O_Heli_Light_02_F"] };
	case "GUER Air": { ["I_Heli_light_03_F"] };
		default { hint "No Valid Vehicle Set"; };
	};

	for "_i" from 0 to floor _times do
	{
		_spawnMarker = [getMarkerPos _marker, 100 * sqrt random 1, random 360] call BIS_fnc_relPos;
		_randomUnit = _soldierArray call BIS_fnc_selectrandom;
		_randomVehicle = _vehicleArray call BIS_fnc_selectrandom;

		_grp = createGroup _side;
		_veh = createVehicle [_randomVehicle, _spawnMarker, [], 0, "FLY"];

		if (_veh emptyPositions "commander" > 0) then
		{
			_vehicleCommander = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleCommander setRank "SERGEANT";
			_vehicleCommander moveInCommander _veh;
			attackGroup pushBack _vehicleCommander;
		};

		if (_veh emptyPositions "driver" > 0) then
		{
			_vehicleDriver = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleDriver setRank "CORPORAL";
			_vehicleDriver moveInDriver _veh;
			attackGroup pushBack _vehicleDriver;
		};

		if (_veh emptyPositions "gunner" > 0) then
		{
			_vehicleGunner = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleGunner setRank "PRIVATE";
			_vehicleGunner moveInGunner _veh;
			attackGroup pushBack _vehicleGunner;
		};

		{
			_x setSkill ["general", 0.4];
			_x setSkill ["aimingAccuracy", 0.3];
			_x setSkill ["aimingShake", 0.3];
			_x setSkill ["aimingSpeed", 0.3];
			_x setSkill ["endurance", 0.4];
			_x setSkill ["spotDistance", 0.4];
			_x setSkill ["spotTime", 0.4];
			_x setSkill ["courage", 0.4];
			_x setSkill ["reloadSpeed", 0.4];
			_x setSkill ["commanding", 0.4];
		} forEach units group _vehicleDriver;

		_wp = _grp addWaypoint [getMarkerPos _attackMarker, 0];
		_wp setWaypointType "SAD";
		_grp setBehaviour "COMBAT";
		_grp setCombatMode "RED";
		_formations = ["COLUMN","STAG COLUMN","LINE","WEDGE"];
		_chosenFormations = _formations call BIS_fnc_selectrandom;
		_grp setFormation _chosenFormations;
	};
};

//["SPAWNMARKERNAME", 30, 1, 300, "Sh_82mm_AMOS"] spawn fnc_MortarAttack;
fnc_MortarAttack = {
	_marker = _this select 0;
	_number = _this select 1;
	_sleep = _this select 2;
	_radius = _this select 3;
	_round = _this select 4;

	for "_i" from 0 to floor _number do
	{
		_psn = [getMarkerPos _marker, _radius * sqrt random 1, random 360] call BIS_fnc_relPos;
		_psn set [2, (_psn select 2) + 100];
		_mortar = createVehicle [_round, [0,0,0], [], 0, "FLY"];
		_mortar setPos _psn;
		_mortar setVelocity [0,0,-15];
		sleep _sleep;
	};
};

attackGroup = [];
