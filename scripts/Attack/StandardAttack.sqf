if (!isServer) exitWith {};
// ["MARKERNAME","ATTACKMARKERNAME","FACTION",Side,1] spawn fnc_StandardAttack;
fnc_StandardAttack = {
	private ["_marker","_attackMarker","_faction","_side","_times","_soldierArray","_randomGroupLeader","_spawnMarker","_grp","_groupLeader","_randomGroupMember","_groupMember","_wp","_formations","_chosenFormations"];
	_marker = _this select 0;
	_attackMarker = _this select 1;
	_faction = _this select 2;
	_side = _this select 3;
	_times = _this select 4;

	switch (_faction) do 
	{
		case "US OCP": { _soldierArray = ["rhsusf_army_ocp_squadleader", "rhsusf_army_ocp_teamleader","rhsusf_army_ocp_rifleman","rhsusf_army_ocp_rifleman", "rhsusf_army_ocp_riflemanat", "rhsusf_army_ocp_medic","rhsusf_army_ocp_machinegunner", "rhsusf_army_ocp_grenadier","rhsusf_army_ocp_autorifleman","rhsusf_army_ocp_javelin","rhsusf_army_ocp_aa"];};
		case "US UCP": { _soldierArray = ["rhsusf_army_ucp_squadleader", "rhsusf_army_ucp_teamleader","rhsusf_army_ucp_rifleman","rhsusf_army_ucp_rifleman", "rhsusf_army_ucp_riflemanat", "rhsusf_army_ucp_medic","rhsusf_army_ucp_machinegunner", "rhsusf_army_ucp_grenadier","rhsusf_army_ucp_autorifleman","rhsusf_army_ucp_javelin","rhsusf_army_ucp_aa"];};
		case "Haji": { _soldierArray = ["CAF_AG_ME_T_AK47", "CAF_AG_ME_T_AK74", "CAF_AG_ME_T_GL", "CAF_AG_ME_T_RPG","CAF_AG_ME_T_PKM", "CAF_AG_ME_T_RPK74","CAF_AG_ME_T_SVD"]; };
		case "Pirate": { _soldierArray = ["CAF_AG_AFR_P_AK47", "CAF_AG_AFR_P_AK74", "CAF_AG_AFR_P_GL", "CAF_AG_AFR_P_PKM","CAF_AG_AFR_P_RPG", "CAF_AG_AFR_P_RPK74","CAF_AG_AFR_P_SVD"]; };
		case "Euro": { _soldierArray = ["CAF_AG_EEUR_R_AK47", "CAF_AG_EEUR_R_AK74", "CAF_AG_EEUR_R_GL", "CAF_AG_EEUR_R_PKM","CAF_AG_EEUR_R_RPG", "CAF_AG_EEUR_R_RPK74","CAF_AG_EEUR_R_SVD"]; };
		case "RU": { _soldierArray = ["rhs_vdv_sergeant", "rhs_vdv_LAT","rhs_vdv_rifleman","rhs_vdv_rifleman", "rhs_vdv_rifleman", "rhs_vdv_medic","rhs_vdv_marksman", "rhs_vdv_machinegunner","rhs_vdv_at","rhs_vdv_grenadier","rhs_vdv_aa"]; };
		case "ChDKZ": { _soldierArray = ["LOP_ChDKZ_Soldier_SL", "LOP_ChDKZ_Soldier_TL","LOP_ChDKZ_Soldier","LOP_ChDKZ_Soldier_Marksman", "LOP_ChDKZ_Soldier_AR", "LOP_ChDKZ_Soldier_GL","LOP_ChDKZ_Soldier_Engineer", "LOP_ChDKZ_Soldier_Medic","LOP_ChDKZ_Soldier_AT"]; };
		default { hint "No Valid Side Set"; []}; 
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