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

if(isNil "DAC_STRPlayers")		then {		DAC_STRPlayers		= ["s_1","s_2","s_3","s_4","s_5","s_6","s_7","s_8","s_9","s_10","s_11","s_12","s_13","s_14","s_15","s_16","s_17","s_18","s_19","s_20","s_21","s_22","s_23","s_24","s_25","s_26","s_27","s_28","s_29","s_30","s_31","s_32","s_33","s_34","s_35","s_36","s_37","s_38","s_39","s_40","s_41","s_42","s_43","s_44","s_45","s_46","s_47","s_48","s_49","s_50","s_51","s_52","s_53","s_54","s_55","s_56","s_57","s_58","s_59","s_60","s_61","s_62","s_63","s_64","s_65","s_66","s_67","s_68","s_69","s_70","s_71","s_72","s_73","s_74","s_75","s_76","s_77","s_78","s_79","s_80","s_81","s_82","s_83","s_84","s_85","s_86","s_87","s_88","s_89","s_90","s_91","s_92","s_93","s_94","s_95","s_96","s_97","s_98","s_99","s_100","s_101","s_102","s_103","s_104","s_105","s_106","s_107","s_108","s_109","s_110","s_111","s_112","s_113","s_114","s_115","s_116","s_117","s_118","s_119","s_120","s_121","s_122","s_123","s_124","s_125","s_126","s_127","s_128"] };
if(isNil "DAC_AI_Count_Level")	then {		DAC_AI_Count_Level  = [[1,3],[4,6],[7,9],[10,12],[1,0]]			};
if(isNil "DAC_Dyn_Weather") 	then {		DAC_Dyn_Weather		= [0,0,0,[0, 0, 0],0]						};
if(isNil "DAC_Reduce_Value") 	then {		DAC_Reduce_Value	= [1200,1300,0.3]								};
if(isNil "DAC_AI_Spawn") 		then {		DAC_AI_Spawn		= [[10,5,5],[10,5,15],0,120,250,0]			};
if(isNil "DAC_Delete_Value") 	then {		DAC_Delete_Value	= [[1200,500],[0,0],0]				};
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
if(isNil "DAC_Activate_Sound")	then {		DAC_Activate_Sound	= true										};
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