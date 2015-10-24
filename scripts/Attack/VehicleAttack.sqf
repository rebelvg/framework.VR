if (!isServer) exitWith {};
// ["MARKERNAME","ATTACKMARKERNAME","FACTION","VEHICLE",Side,1] spawn fnc_VehicleAttack;
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
		case "US OCP": { _soldierArray = ["rhsusf_army_ocp_rifleman"];};
		case "US UCP": { _soldierArray = ["rhsusf_army_ucp_rifleman"];};
		case "Haji": { _soldierArray = ["CAF_AG_ME_T_AK47"]; };
		case "Pirate": { _soldierArray = ["CAF_AG_AFR_P_AK47"]; };
		case "Euro": { _soldierArray = ["CAF_AG_EEUR_R_AK47"]; };
		case "RU": { _soldierArray = ["rhs_vdv_rifleman"]; };
		default { hint "No Valid Side Set"; []}; 
	};

	_vehicleArray = switch (_vehicle) do 
	{
		case "US OCP APC": {["rhsusf_m113_usarmy"]; };
		case "US UCP APC": {["rhsusf_m113d_usarmy"]; };
		case "US OCP IFV": {["RHS_M2A3_wd"]; };
		case "US UCP IFV": {["RHS_M2A3"]; };
		case "US OCP HMMWV": {["rhsusf_m1025_w_m2"]; };
		case "US UCP HMMWV": {["rhsusf_m1025_d_s_m2"]; };
		case "US OCP Armour": {["rhsusf_m1a1aim_tuski_wd"]; };
		case "US UCP Armour": {["rhsusf_m1a1aim_tuski_d"]; };
		case "Technical": {["CAF_AG_ME_T_Offroad_armed_01"]; };
		case "RU APC": {["rhs_btr60_vdv", "rhs_btr70_vdv", "rhs_btr80_vdv", "rhs_btr80a_vdv"]; };
		case "RU IFV": {["rhs_bmd1", "rhs_bmd2", "rhs_bmd4_vdv", "rhs_bmp1_vdv","rhs_bmp1k_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_bmp2e_vdv","rhs_bmp1p_vdv","rhs_bmp1d_vdv"]; };
		case "RU Armour": {["rhs_t72ba_tv", "rhs_t72bb_tv", "rhs_t72bc_tv", "rhs_t80a","rhs_t80b"]; };
		default { hint "No Valid Vehicle Set" }; 
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
			_x setSkill ["general", 0.7];						
			_x setSkill ["aimingAccuracy", 0.4];
			_x setSkill ["aimingShake", 0.4];						
			_x setSkill ["aimingSpeed", 0.6];
			_x setSkill ["endurance", 0.6];
			_x setSkill ["spotDistance", 0.6];
			_x setSkill ["spotTime", 0.6];
			_x setSkill ["courage", 0.7];
			_x setSkill ["reloadSpeed", 0.7];
			_x setSkill ["commanding", 0.7];
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