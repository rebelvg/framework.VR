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

private _conf = missionConfigFile >> "KF_AI" >> "Units";

switch (_TypNumber) do
{
    //-------------------------------------------------------------------------------------------------
    //EAST
case 0:
    {
        //"crew", "pilot", "sl", "all other units", minimum 4 units
        _Unit_Pool_S = (getArray (_conf >> "EAST" >> "crew")) + (getArray (_conf >> "EAST" >> "infantry"));
        _Unit_Pool_V = getArray (_conf >> "EAST" >> "wheeled");
        _Unit_Pool_T = getArray (_conf >> "EAST" >> "armored");
        _Unit_Pool_A = getArray (_conf >> "EAST" >> "air");
    };
    //-------------------------------------------------------------------------------------------------
    //WEST
case 1:
    {
        _Unit_Pool_S = (getArray (_conf >> "WEST" >> "crew")) + (getArray (_conf >> "WEST" >> "infantry"));
        _Unit_Pool_V = getArray (_conf >> "WEST" >> "wheeled");
        _Unit_Pool_T = getArray (_conf >> "WEST" >> "armored");
        _Unit_Pool_A = getArray (_conf >> "WEST" >> "air");
    };
    //-------------------------------------------------------------------------------------------------
    //RESISTANCE
case 2:
    {
        _Unit_Pool_S = (getArray (_conf >> "GUER" >> "crew")) + getArray ((_conf >> "GUER" >> "infantry"));
        _Unit_Pool_V = getArray (_conf >> "GUER" >> "wheeled");
        _Unit_Pool_T = getArray (_conf >> "GUER" >> "armored");
        _Unit_Pool_A = getArray (_conf >> "GUER" >> "air");
    };
    //-------------------------------------------------------------------------------------------------
    //CIVILIAN
case 3:
    {
        _Unit_Pool_S = ["C_man_1","C_man_1","C_man_1","C_man_1"];
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