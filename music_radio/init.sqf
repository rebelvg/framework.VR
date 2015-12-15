murshun_musicArray = "gettext (_x >> 'tag') == 'Poddy Music'" configClasses (configFile >> "CfgMusic");

if (count murshun_musicArray == 0) exitWith {hint "murshun_musicArray is empty.";};

KK_fnc_arrayShufflePlus = {
    private ["_arr","_cnt"];
    _arr = _this select 0;
    _cnt = count _arr;
    for "_i" from 1 to (_this select 1) do {
        _arr pushBack (_arr deleteAt floor random _cnt);
    };
    _arr
};

murshun_musicArray = [murshun_musicArray, 4 * count murshun_musicArray] call KK_fnc_arrayShufflePlus;

if (isNil "murshun_whatSong") then {
murshun_whatSong = "";
};

if (isNil "murshun_timeStarted") then {
murshun_timeStarted = 0;
};

murshun_playSongOnRadio_fnc = {
_car = _this select 0;

if (isServer) then {
_car setVariable ["murshun_radioIsOn", true, true];
};

if (player in crew _car) then {
playMusic "";
playMusic [murshun_whatSong, time - murshun_timeStarted];

if ((gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "name") != "")) then {
[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", toUpper (gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "name")), "by" + " " + (gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "artist"))], true, nil, 7, 1, 0] spawn BIS_fnc_textTiles;
};
};
};

murshun_sendNewSong_fnc = {
_car = vehicle player;
_song = _this select 0;

if (player in crew _car && vehicle player != player && (_car getVariable ['murshun_radioIsOn', false]) && (_car getVariable ['murshun_hasRadio', false])) then {
playMusic "";
playMusic _song;

if ((gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "name") != "")) then {
[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", toUpper (gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "name")), "by" + " " + (gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "artist"))], true, nil, 7, 1, 0] spawn BIS_fnc_textTiles;
};
};
};

murshun_stopSongOnRadio_fnc = {
_car = _this select 0;

if (isServer) then {
_car setVariable ["murshun_radioIsOn", false, true];
};

if (player in crew _car) then {
playMusic "";
};
};

murshun_addActionVehRadio_fnc = {
_veh = _this select 0;

_veh addEventHandler ["GetIn",{
_car = _this select 0;
_playerEntered = _this select 2;

if (_playerEntered == player) then {
_isPlaying = _car getVariable ["murshun_radioIsOn", false];

if (_isPlaying) then {
playMusic "";
playMusic [murshun_whatSong, time - murshun_timeStarted];

if ((gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "name") != "")) then {
[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", toUpper (gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "name")), "by" + " " + (gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "artist"))], true, nil, 7, 1, 0] spawn BIS_fnc_textTiles;
};
};
};
}];

_veh addEventHandler ["GetOut",{
_playerExited = _this select 2;

if (_playerExited == player) then {
playMusic "";
};
}];

_veh addAction ["Turn Radio On",{
_car = (_this select 0);

[[_car],"murshun_playSongOnRadio_fnc"] call BIS_fnc_MP;

},[nil],0,false,true,"","vehicle _this != _this && driver _target == _this && !(_target getVariable ['murshun_radioIsOn', false])"];

_veh addAction ["Turn Radio Off",{
_car = (_this select 0);

[[_car],"murshun_stopSongOnRadio_fnc"] call BIS_fnc_MP;

},[nil],0,false,true,"","vehicle _this != _this && driver _target == _this && (_target getVariable ['murshun_radioIsOn', false])"];
};

player addEventHandler ["Respawn", {
playMusic "";
}];

[] spawn {
if (isServer) then {
waituntil {!isNil "murshun_musicArray"};

waituntil {time > 15};

while {true} do {
{
murshun_whatSong = _x;
_config_murshun_whatSong = murshun_whatSong;
murshun_whatSong = configName murshun_whatSong;
murshun_timeStarted = time;

publicVariable "murshun_whatSong";
publicVariable "murshun_timeStarted";

murshun_skipTrack = false;

_songInfo = [murshun_whatSong, "_"] call CBA_fnc_split;
_songLength = _songInfo select 1;
_songLength = parseNumber _songLength;

[[murshun_whatSong],"murshun_sendNewSong_fnc"] call BIS_fnc_MP;

if (!isNil "murshun_musicRadiosArray") then {
if (count murshun_musicRadiosArray > 0) then {
{
playSound3D [((getArray (murshun_musicArray select (murshun_musicArray find _config_murshun_whatSong) >> "sound")) select 0), _x, false, getPosASL _x, 4, 1, 50];
} foreach murshun_musicRadiosArray;
};
};

_time = time;
waituntil {
sleep 1;
time >= _time + _songLength or murshun_skipTrack
};

murshun_skipTrack = false;
} foreach murshun_musicArray;
};
};
};
