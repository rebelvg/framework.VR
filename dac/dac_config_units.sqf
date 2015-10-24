//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 2.1 - 2009    //
//--------------------------//
//    DAC_Config_Units      //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private ["_TypNumber","_TempArray","_Unit_Pool_S","_Unit_Pool_V","_Unit_Pool_T","_Unit_Pool_A"];
_TypNumber = _this select 0;_TempArray = [];

switch (_TypNumber) do
{
//-------------------------------------------------------------------------------------------------
// REDFOR (A3)
  case 0:
  {
    _Unit_Pool_S = ["O_crew_F","O_Helipilot_F","O_Soldier_SL_F","O_soldier_AR_F","O_soldier_AR_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_GL_F","O_soldier_M_F","O_medic_F","O_soldier_AA_F","O_soldier_repair_F","O_Soldier_F","O_Soldier_F","O_soldier_LAT_F","O_soldier_LAT_F","O_soldier_lite_F","O_soldier_TL_F","O_soldier_TL_F"];
    _Unit_Pool_V = ["O_MRAP_02_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F"];
    _Unit_Pool_T = ["O_MBT_02_arty_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MBT_02_cannon_F","O_APC_Tracked_02_AA_F"];
	_Unit_Pool_A = ["O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Light_02_armed_F"];
  };
//-------------------------------------------------------------------------------------------------
// BLUFOR (A3)
  case 1:
  {
    _Unit_Pool_S = ["B_crew_F","B_Helipilot_F","B_Soldier_SL_F","B_soldier_AR_F","B_soldier_AR_F","B_soldier_exp_F","B_soldier_GL_F","B_soldier_GL_F","B_soldier_AA_F","B_soldier_M_F","B_medic_F","B_soldier_repair_F","B_Soldier_F","B_Soldier_F","B_soldier_LAT_F","B_soldier_LAT_F","B_soldier_lite_F","B_soldier_TL_F","B_soldier_TL_F"];
    _Unit_Pool_V = ["B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"];
    _Unit_Pool_T = ["B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_AA_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_arty_F","B_MBT_01_mlrs_F"];
    _Unit_Pool_A = ["B_Heli_Light_01_armed_F","B_Heli_Transport_01_camo_F","B_Heli_Light_01_F"];
  };
//-------------------------------------------------------------------------------------------------
// Independent (A3)
  case 2:
  {
    _Unit_Pool_S = ["I_crew_F","I_helipilot_F","I_officer_F","I_Soldier_AT_F","I_Soldier_AA_F","I_Soldier_M_F","I_Soldier_GL_F","I_Soldier_exp_F","I_engineer_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
    _Unit_Pool_V = ["I_Truck_02_covered_F","I_Truck_02_transport_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MRAP_03_F"];
    _Unit_Pool_T = ["I_MBT_03_cannon_F","I_APC_tracked_03_cannon_F"];
    _Unit_Pool_A = ["I_Heli_light_03_F"];
  };
//-------------------------------------------------------------------------------------------------
// Civilians (A3)
  case 3:
  {
    _Unit_Pool_S = ["C_man_1","C_man_1","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F"];
    _Unit_Pool_V = ["C_Van_01_box_F","C_Van_01_transport_F","C_Offroad_01_F","C_Hatchback_01_sport_F","C_Hatchback_01_F"];
    _Unit_Pool_T = ["C_Van_01_box_F","C_Van_01_transport_F","C_Offroad_01_F","C_Hatchback_01_sport_F","C_Hatchback_01_F"];
    _Unit_Pool_A = [];
  };
  case 4:
  {
	_Unit_Pool_S = [
		//Vehicle crewman, Pilot, Group Leader
		"LOP_PMC_Infantry_Crewman","LOP_PMC_Infantry_Pilot","LOP_PMC_Infantry_SL",
		"LOP_PMC_Infantry_AT", "LOP_PMC_Infantry_AT_Asst", "LOP_PMC_Infantry_Corpsman", "LOP_PMC_Infantry_Engineer", "LOP_PMC_Infantry_GL", "LOP_PMC_Infantry_MG", "LOP_PMC_Infantry_MG_Asst", "LOP_PMC_Infantry_Marksman", "LOP_PMC_Infantry_Rifleman", "LOP_PMC_Infantry_TL"
	];
    _Unit_Pool_V = ["LOP_PMC_Offroad_M2"];
    _Unit_Pool_T = [];
    _Unit_Pool_A = ["LOP_PMC_MH9_armed"];
  };
  case 5:
  {
	_Unit_Pool_S = [
		//Vehicle crewman, Pilot, Group Leader
		"LOP_US_Infantry_Crewman","LOP_US_Infantry_Crewman","LOP_US_Infantry_SL",
		"LOP_US_Infantry_AA", "LOP_US_Infantry_AT", "LOP_US_Infantry_AT_Asst", "LOP_US_Infantry_Corpsman", "LOP_US_Infantry_GL", "LOP_US_Infantry_MG", "LOP_US_Infantry_MG_Asst", "LOP_US_Infantry_Marksman", "LOP_US_Infantry_Officer", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_TL"
	];
    _Unit_Pool_V = ["LOP_US_UAZ_Open"];
    _Unit_Pool_T = ["LOP_US_BTR600", "LOP_US_BTR70"];
    _Unit_Pool_A = [];
  };
  case 6:
  {
	_Unit_Pool_S = [
		//Vehicle crewman, Pilot, Group Leader
		"rhsusf_army_ocp_crewman","rhsusf_army_ocp_helipilot","rhsusf_army_ocp_squadleader",
		"rhsusf_army_ocp_rifleman_101st", "rhsusf_army_ocp_rifleman_10th", "rhsusf_army_ocp_rifleman_1stcav", "rhsusf_army_ocp_rifleman_82nd", "rhsusf_army_ocp_aa", "rhsusf_army_ocp_javelin", "rhsusf_army_ocp_autorifleman", "rhsusf_army_ocp_autoriflemana", "rhsusf_army_ocp_medic", "rhsusf_army_ocp_engineer", "rhsusf_army_ocp_explosives", "rhsusf_army_ocp_grenadier", "rhsusf_army_ocp_riflemanat", "rhsusf_army_ocp_marksman", "rhsusf_army_ocp_teamleader"
	];
    _Unit_Pool_V = ["rhsusf_m1025_d_m2", "rhsusf_rg33_m2_d"];
    _Unit_Pool_T = [];
    _Unit_Pool_A = [];
  };
  case 7:
  {
    _Unit_Pool_S = [
		"rhs_msv_driver_armored", "rhs_msv_combatcrew", "rhs_msv_sergeant",
		"rhs_msv_rifleman",
		"rhs_msv_grenadier",
		"rhs_msv_at",						//grenadier RPG
		"rhs_msv_strelok_rpg_assist",		//grenadier RPG assistant
		"rhs_msv_aa",
		"rhs_msv_efreitor",
		"rhs_msv_engineer",
		"rhs_msv_machinegunner",
		"rhs_msv_machinegunner_assistant",
		"rhs_msv_marksman",
		"rhs_msv_medic",
		"rhs_msv_LAT",						//rifleman RPG-26
		"rhs_msv_RShG2"						//rifleman RShG2
		
	];
    _Unit_Pool_V = [
		"rhs_tigr_msv",						//MRAP	
		"rhs_uaz_open_MSV_01"	
	];
    _Unit_Pool_T = ["rhs_btr80_msv"];
    _Unit_Pool_A = ["RHS_Mi24V_vvsc"];
  };
  case 8:
  {
	_Unit_Pool_S = [
		//Vehicle crewman, Pilot, Group Leader
		"LOP_UA_Infantry_Crewman","LOP_UA_Infantry_Pilot","LOP_UA_Infantry_SL",
		"LOP_UA_Infantry_AT_Asst", "LOP_UA_Infantry_MG_Asst", "LOP_UA_Infantry_AT", "LOP_UA_Infantry_Corpsman", "LOP_UA_Infantry_Engineer", "LOP_UA_Infantry_GL", "LOP_UA_Infantry_MG", "LOP_UA_Infantry_Marksman", "LOP_UA_Officer", "LOP_UA_Infantry_Rifleman", "LOP_UA_Infantry_TL"
	];
    _Unit_Pool_V = ["LOP_UA_UAZ", "LOP_UA_Ural"];
    _Unit_Pool_T = ["LOP_UA_BMP1", "LOP_UA_BMP2"];
    _Unit_Pool_A = ["LOP_UA_Mi8MTV3_FAB"];
  };
  case 9:
  {
	_Unit_Pool_S = [
		//Vehicle crewman, Pilot, Group Leader
		"LOP_ISTS_Infantry_Rifleman","LOP_ISTS_Infantry_Rifleman","LOP_ISTS_Infantry_SL",
		"LOP_ISTS_Infantry_AT", "LOP_ISTS_Infantry_AR", "LOP_ISTS_Infantry_Corpsman", "LOP_ISTS_Infantry_GL", "LOP_ISTS_Infantry_Engineer", "LOP_ISTS_Infantry_Marksman", "LOP_ISTS_Infantry_Rifleman", "LOP_ISTS_Infantry_TL"
	];
    _Unit_Pool_V = ["LOP_ISTS_Offroad_M2", "LOP_ISTS_Landrover_M2"];
    _Unit_Pool_T = ["LOP_ISTS_BTR60", "LOP_ISTS_BMP1"];
    _Unit_Pool_A = [];
  };
  case 10:
  {
	_Unit_Pool_S = [
		//Vehicle crewman, Pilot, Group Leader
		"rhsusf_army_ucp_crewman","rhsusf_army_ucp_helipilot","rhsusf_army_ucp_squadleader",
		"rhsusf_army_ucp_rifleman_101st", "rhsusf_army_ucp_rifleman_10th", "rhsusf_army_ucp_rifleman_1stcav", "rhsusf_army_ucp_rifleman_82nd", "rhsusf_army_ucp_aa", "rhsusf_army_ucp_javelin", "rhsusf_army_ucp_autorifleman", "rhsusf_army_ucp_autoriflemana", "rhsusf_army_ucp_medic", "rhsusf_army_ucp_engineer", "rhsusf_army_ucp_explosives", "rhsusf_army_ucp_grenadier", "rhsusf_army_ucp_riflemanat", "rhsusf_army_ucp_marksman", "rhsusf_army_ucp_teamleader"
	];
    _Unit_Pool_V = ["rhsusf_rg33_m2_wd"];
    _Unit_Pool_T = ["RHS_M2A3_BUSKIII_wd"];
    _Unit_Pool_A = ["RHS_UH60M"];
  };
//-------------------------------------------------------------------------------------------------
  Default
  {
    if(DAC_Basic_Value != 5) then
    {
      DAC_Basic_Value = 5;publicvariable "DAC_Basic_Value",
      hintc "Error: DAC_Config_Units > No valid config number";
    };
    if(true) exitwith {};
  };
};

if(count _this == 2) then
{
  _TempArray = _TempArray + [_Unit_Pool_S,_Unit_Pool_V,_Unit_Pool_T,_Unit_Pool_A];
}
else
{
  _TempArray = _Unit_Pool_V + _Unit_Pool_T + _Unit_Pool_A;
};
_TempArray