//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Behaviour  //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private [
"_array","_setSkill","_setCombat","_setBehav","_setSpeed","_setForm","_setPatrol","_setSearch",
"_setFleeing","_setHeliVal","_setPause","_setBldgBeh","_setSupport","_setJoin","_setEmpVeh","_setSupTime","_setHidTime"
];

private _conf = missionConfigFile >> "KF_AI" >> "Behaviour";

switch (_this select 0) do
{
    //-------------------------------------------------------------------------------------------------------------------------
    //infantry
case 0:
    {
        //"aimingAccuracy", "aimingShake", "aimingSpeed", "endurance", "spotDistance", "spotTime", "courage", "reloadSpeed", "commanding", "general"
        _setSkill   = getArray (_conf >> "LOW" >> "Infantry" >> "skill");
        _setCombat  = ["yellow"];
        _setBehav   = ["safe","aware"];
        _setSpeed   = ["limited","normal","full"];
        _setForm    = ["line","vee","column","wedge","stag column","ech left","ech right","file","diamond"];
        _setFleeing = [0,200];
        _setHeliVal = [100,300,1,1];
        _setPause   = [[5,10],[5,10],[5,10],[20,30,5,5],[1,3],[0,0]];
        _setBldgBeh = [0,50,120,600,2];
        _setPatrol  = ["15","30"];
        _setSearch  = ["40 + ((skill _leader) * 150)","50 + ((skill _leader) * 50)"];
        _setSupport = [0,0];
        _setJoin    = 0;
        _setEmpVeh  = [[0,100],[0,100]];
        _setSupTime = ["5 + ((skill _unit) * (5 * DAC_AI_Level))",2,5];
        _setHidTime = ["(((10 * DAC_AI_Level) + ((skill _leader) * 50)) / ((count units _group) + 1))"];
    };
    //vehicles
case 4:
    {
        _setSkill   = getArray (_conf >> "LOW" >> "Vehicles" >> "skill");
        _setCombat  = ["yellow"];
        _setBehav   = ["safe"];
        _setSpeed   = ["limited","normal"];
        _setForm    = ["line","vee","column","wedge","stag column","ech left","ech right","file","diamond"];
        _setFleeing = [0,200];
        _setHeliVal = [100,300,1,1];
        _setPause   = [[5,10],[5,10],[5,10],[20,30,5,5],[1,3],[0,0]];
        _setBldgBeh = [0,50,120,600,2];
        _setPatrol  = ["15","30"];
        _setSearch  = ["40 + ((skill _leader) * 150)","50 + ((skill _leader) * 50)"];
        _setSupport = [0,0];
        _setJoin    = 0;
        _setEmpVeh  = [[0,100],[0,100]];
        _setSupTime = ["5 + ((skill _unit) * (5 * DAC_AI_Level))",2,5];
        _setHidTime = ["(((10 * DAC_AI_Level) + ((skill _leader) * 50)) / ((count units _group) + 1))"];
    };
    //-------------------------------------------------------------------------------------------------------------------------
    Default {
        if(DAC_Basic_Value != 5) then
        {
            DAC_Basic_Value = 5;
            publicVariable "DAC_Basic_Value";
            hintc "Error: DAC_Config_Behaviour > No valid config number";
        };
        if(true) exitwith {};
    };
};

_array =	[
_setSkill,_setCombat,_setBehav,_setSpeed,_setForm,_setFleeing,
_setHeliVal,_setPause,_setBldgBeh,_setPatrol,_setSearch,
_setSupport,_setJoin,_setEmpVeh,_setSupTime,_setHidTime
];
_array
