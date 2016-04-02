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
		_Unit_Pool_S = ["O_crew_F","O_Helipilot_F","O_Soldier_SL_F","O_soldier_AR_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_M_F","O_medic_F","O_soldier_AA_F","O_soldier_repair_F","O_Soldier_F","O_soldier_LAT_F","O_soldier_lite_F","O_soldier_TL_F"];
		_Unit_Pool_V = ["O_MRAP_02_F"];
		_Unit_Pool_T = ["O_APC_Wheeled_02_rcws_F","O_MBT_02_cannon_F"];
		_Unit_Pool_A = ["O_Heli_Light_02_F"];
	};
	//-------------------------------------------------------------------------------------------------
	// BLUFOR (A3)
case 1:
	{
		_Unit_Pool_S = ["B_crew_F","B_Helipilot_F","B_Soldier_SL_F","B_soldier_AR_F","B_soldier_exp_F","B_soldier_GL_F","B_soldier_AA_F","B_soldier_M_F","B_medic_F","B_soldier_repair_F","B_Soldier_F","B_soldier_LAT_F","B_soldier_lite_F","B_soldier_TL_F"];
		_Unit_Pool_V = ["B_MRAP_01_F"];
		_Unit_Pool_T = ["B_APC_Wheeled_01_cannon_F","B_MBT_01_TUSK_F"];
		_Unit_Pool_A = ["B_Heli_Transport_01_F"];
	};
	//-------------------------------------------------------------------------------------------------
	// Independent (A3)
case 2:
	{
		_Unit_Pool_S = ["I_crew_F","I_Helipilot_F","I_Soldier_SL_F","I_soldier_AR_F","I_soldier_exp_F","I_soldier_GL_F","I_soldier_AA_F","I_soldier_M_F","I_medic_F","I_soldier_repair_F","I_Soldier_F","I_soldier_LAT_F","I_soldier_lite_F","I_soldier_TL_F"];
		_Unit_Pool_V = ["I_MRAP_03_F"];
		_Unit_Pool_T = ["I_APC_Wheeled_03_cannon_F","I_MBT_03_cannon_F"];
		_Unit_Pool_A = ["I_Heli_light_03_F"];
	};
	//-------------------------------------------------------------------------------------------------
	// Civilians (A3)
case 3:
	{
		_Unit_Pool_S = ["C_man_1","C_man_1","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F"];
		_Unit_Pool_V = ["C_Offroad_01_F"];
		_Unit_Pool_T = [];
		_Unit_Pool_A = ["C_Heli_Light_01_civil_F"];
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