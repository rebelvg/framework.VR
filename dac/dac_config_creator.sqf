//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Creator    //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

scalar = "any";DAC_Init_Camps = 0;

waituntil{time > 0.3};

if(isServer) then {if(local player) then {DAC_Code = 1} else {DAC_Code = 0}} else {if(isnull player) then {DAC_Code = 3} else {DAC_Code = 2}};

//===============|
// DAC_Settings	 |
//===============|=============================================================================================|

if(isNil "DAC_STRPlayers")		then {		DAC_STRPlayers		= ["b_1","b_2","b_3","b_4","b_5","b_6","b_7","b_8","b_9","b_10","b_11","b_12","b_13","b_14","b_15","b_16","b_17","b_18","b_19","b_20","b_21","b_22","b_23","b_24","b_25","b_26","b_27","b_28","b_29","b_30","b_31","b_32","b_33","b_34","b_35","b_36","b_37","b_38","b_39","b_40","b_41","o_1","o_2","o_3","o_4","o_5","o_6","o_7","o_8","o_9","o_10","o_11","o_12","o_13","o_14","o_15","o_16","o_17","o_18","o_19","o_20","o_21","o_22","o_23","o_24","o_25","o_26","o_27","o_28","o_29","o_30","o_31","o_32","o_33","o_34","o_35","o_36","o_37","o_38","o_39","o_40","o_41","i_1","i_2","i_3","i_4","i_5","i_6","i_7","i_8","i_9","i_10","i_11","i_12","i_13","i_14","i_15","i_16","i_17","i_18","i_19","i_20","i_21","i_22","i_23","i_24","i_25","i_26","i_27","i_28","i_29","i_30","i_31","i_32","i_33","i_34","i_35","i_36","i_37","i_38","i_39","i_40","i_41"] };
if(isNil "DAC_AI_Count_Level")	then {		DAC_AI_Count_Level  = [[1,3],[4,6],[7,9],[10,12],[1,0]]			};
if(isNil "DAC_Dyn_Weather") 	then {		DAC_Dyn_Weather		= [0,0,0,[0, 0, 0],0]						};
if(isNil "DAC_Reduce_Value") 	then {		DAC_Reduce_Value	= [800,900,0.3]								};
if(isNil "DAC_AI_Spawn") 		then {		DAC_AI_Spawn		= [[10,5,5],[10,5,15],0,120,250,0]			};
if(isNil "DAC_Delete_Value") 	then {		DAC_Delete_Value	= [[180,150],[0,0],0]				};
if(isNil "DAC_Del_PlayerBody") 	then {		DAC_Del_PlayerBody	= [0,0]										};
if(isNil "DAC_Com_Values") 		then {		DAC_Com_Values		= [0,1,0,0]									};
if(isNil "DAC_AI_AddOn") 		then {		DAC_AI_AddOn		= 1											};
if(isNil "DAC_AI_Level") 		then {		DAC_AI_Level		= 3											};
if(isNil "DAC_Res_Side") 		then {		DAC_Res_Side		= 0											};
if(isNil "DAC_Marker") 			then {		DAC_Marker			= 0											};
if(isNil "DAC_WP_Speed") 		then {		DAC_WP_Speed		= 0.01										};
if(isNil "DAC_Join_Action")		then {		DAC_Join_Action		= false										};
if(isNil "DAC_Fast_Init") 		then {		DAC_Fast_Init		= false										};
if(isNil "DAC_Player_Marker")	then {		DAC_Player_Marker	= false										};
if(isNil "DAC_Direct_Start")	then {		DAC_Direct_Start	= false										};
if(isNil "DAC_Activate_Sound")	then {		DAC_Activate_Sound	= false										};
if(isNil "DAC_Auto_UnitCount")	then {		DAC_Auto_UnitCount	= [8,10]									};
if(isNil "DAC_Player_Support")	then {		DAC_Player_Support	= [10,[4,2000,3,1000]]						};
if(isNil "DAC_SaveDistance")	then {		DAC_SaveDistance	= [500,["DAC_Save_Pos"]]					};
if(isNil "DAC_Radio_Max")		then {		DAC_Radio_Max		= DAC_AI_Level								};

DAC_BadBuildings 	= 	[];
DAC_GunNotAllowed	= 	[];
DAC_VehNotAllowed	= 	[];
DAC_Locked_Veh		=	[];
DAC_SP_Soldiers     =   ["B_soldier_AR_F","B_G_soldier_AR_F","O_soldier_AR_F","O_soldierU_AR_F","O_G_soldier_AR_F","I_soldier_AR_F","I_G_soldier_AR_F"];
DAC_Data_Array 		= 	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,[]];
DAC_Marker_Val		= 	[];
DAC_Zones			=	[];

//=============================================================================================================|

_scr = [] spawn (compile preprocessFile "\DAC_Source\Scripts\DAC_Start_Creator.sqf");
waituntil {scriptdone _scr};
sleep 0.1;
waituntil {(DAC_Basic_Value > 0)};

if(DAC_Code < 2) then
{
	//===========================================|
	// StartScriptOnServer                       |
	//===========================================|
	//player sidechat "ServerStart"
	//[] execVM "myServerScript.sqf";
	//onMapSingleClick "_fun = [_pos,_shift]execVM ""Action.sqf""";
}
else
{
	if(DAC_Code == 3) then
	{
		//===========================================|
		// StartScriptOnJipClient                    |
		//===========================================|
		//player sidechat "JipClientStart"
		//[] execVM "myJipClientScript.sqf";
	}
	else
	{
		//===========================================|
		// StartScriptOnClient                       |
		//===========================================|
		//player sidechat "ClientStart"
		//[] execVM "myClientScript.sqf";
		//onMapSingleClick "_fun = [_pos,_shift]execVM ""Action.sqf""";
	};
};