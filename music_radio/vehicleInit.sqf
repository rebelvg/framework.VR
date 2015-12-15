_unit = (_this select 0);

if (!isServer) exitWith {};

_unit setVariable ["murshun_hasRadio", true, true];
_unit setVariable ["murshun_radioIsOn", false, true];

_unit addMPEventHandler ["MPKilled",{
_car = _this select 0;

[[_car],"murshun_stopSongOnRadio_fnc"] call BIS_fnc_MP;
}];

waituntil {time > 1};

[[_unit],"murshun_addActionVehRadio_fnc", true, true] call BIS_fnc_MP;
