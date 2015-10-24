if (!isServer) exitWith {};
// ["MARKERNAME","ATTACKMARKERNAME","FACTION","VEHICLE",Side,1] spawn fnc_HeliAttack;
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
		case "US OCP": { _soldierArray = ["rhsusf_army_ocp_helipilot"];};
		case "US UCP": { _soldierArray = ["rhsusf_army_ucp_helipilot"];};
		case "Haji": { _soldierArray = ["CAF_AG_ME_T_AK47"]; };
		case "Pirate": { _soldierArray = ["CAF_AG_AFR_P_AK47"]; };
		case "Euro": { _soldierArray = ["CAF_AG_EEUR_R_AK47"]; };
		case "RU": { _soldierArray = ["rhs_pilot"]; };
		default { hint "No Valid Side Set"; []}; 
	};

	_vehicleArray = switch (_vehicle) do 
	{
		case "US OCP AH": {["RHS_AH64D_wd"]; };
		case "US UCP AH": {["RHS_AH64D"]; };
		case "US BLCK HWK": {["RHS_UH60M_d"]; };
		case "US LB": {["B_Heli_Light_01_armed_F"]; };
		case "RU KA": {["RHS_Ka52_vvsc"]; };
		case "RU MI8": {["RHS_Mi8AMTSh_vvsc"]; };
		case "RU HIND": {["RHS_Mi24V_vvsc"]; };
		default { hint "No Valid Vehicle Set" }; 
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

		if (_veh isKindOf "RHS_UH60M_d") then 
		{
			_vehicleGunner3 = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleGunner3 setRank "PRIVATE";
			_vehicleGunner3 moveInTurret [_veh,[2]];
			attackGroup pushBack _vehicleGunner3;		
		};
		
		if (_veh isKindOf "RHS_Mi8AMTSh_vvsc") then 
		{
			_vehicleGunner2 = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleGunner2 setRank "PRIVATE";
			_vehicleGunner2 moveInTurret [_veh,[1]];
			attackGroup pushBack _vehicleGunner2;
			
			_vehicleGunner3 = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleGunner3 setRank "PRIVATE";
			_vehicleGunner3 moveInTurret [_veh,[2]];
			attackGroup pushBack _vehicleGunner3;
			
			_vehicleCoPilot = _grp createUnit [_randomUnit, [0,0,0], [], 0, "FORM"];
			_vehicleCoPilot setRank "PRIVATE";
			_vehicleCoPilot moveInTurret [_veh,[0]];
			attackGroup pushBack _vehicleCoPilot;			
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
		_wp setWaypointType "LOITER";
		_grp setBehaviour "COMBAT";
		_grp setCombatMode "RED";
		_formations = ["COLUMN","STAG COLUMN","LINE","WEDGE"];
		_chosenFormations = _formations call BIS_fnc_selectrandom;
		_grp setFormation _chosenFormations;
	};
};