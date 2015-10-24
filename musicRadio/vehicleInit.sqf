_unit = (_this select 0);

if (!isServer) exitWith {};

_unit setVariable ["hasRadio", true, true];
_unit setVariable ["radioIsOn", false, true];

_unit addMpEventHandler ["MPKilled",{
_car = _this select 0;

[[_car],"stopSongOnRadio_fnc"] call BIS_fnc_MP;
}];

waituntil {
sleep 1;
count crew _unit > 0 or !alive _unit
};

if (!alive _unit) exitWith {};

[[_unit],"addActionVehRadio_fnc", true, true] call BIS_fnc_MP;
