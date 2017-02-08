if (!isMultiplayer) then {
    [] call mf_debugLoadout_fnc;
};

if (isMultiplayer && ("AddZeus" call BIS_fnc_getParamValue) == 0) then {
    {
        deleteVehicle _x;
    } forEach allCurators;
};

if (("StartTime" call BIS_fnc_getParamValue) != -1) then {
    ["StartTime" call BIS_fnc_getParamValue] call BIS_fnc_paramDaytime;
};

if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
    [mf_fnc_fixAcreDesync, 20, []] call CBA_fnc_addPerFrameHandler;
};
