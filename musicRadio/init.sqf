musicArray = "gettext (_x >> 'tag') == 'Poddy Music'" configClasses (configFile >> "cfgMusic");

if (count musicArray == 0) exitWith {hint "musicArray is empty.";};

KK_fnc_arrayShufflePlus = {
    private ["_arr","_cnt"];
    _arr = _this select 0;
    _cnt = count _arr;
    for "_i" from 1 to (_this select 1) do {
        _arr pushBack (_arr deleteAt floor random _cnt);
    };
    _arr
};

musicArray = [musicArray, 2 * count musicArray] call KK_fnc_arrayShufflePlus;

if (isNil "whatSong") then {
whatSong = "";
};

if (isNil "timeStarted") then {
timeStarted = 0;
};

playSongOnRadio_fnc = {
_car = _this select 0;

if (isServer) then {
_car setVariable ["radioIsOn", true, true];
};

if (player in crew _car) then {
playMusic "";
playMusic [whatSong, serverTime - timeStarted];

if ((gettext (configfile >> "CfgMusic" >> whatSong >> "name") != "")) then {
[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", toUpper (gettext (configfile >> "CfgMusic" >> whatSong >> "name")), "by" + " " + (gettext (configfile >> "CfgMusic" >> whatSong >> "artist"))], true, nil, 7, 1, 0] spawn BIS_fnc_textTiles;
};
};
};

sendNewSong_fnc = {
_car = vehicle player;
_song = _this select 0;

if (player in crew _car && vehicle player != player && (_car getVariable ['radioIsOn', false]) && (_car getVariable ['hasRadio', false])) then {
playMusic "";
playMusic _song;

if ((gettext (configfile >> "CfgMusic" >> whatSong >> "name") != "")) then {
[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", toUpper (gettext (configfile >> "CfgMusic" >> whatSong >> "name")), "by" + " " + (gettext (configfile >> "CfgMusic" >> whatSong >> "artist"))], true, nil, 7, 1, 0] spawn BIS_fnc_textTiles;
};
};
};

stopSongOnRadio_fnc = {
_car = _this select 0;

if (isServer) then {
_car setVariable ["radioIsOn", false, true];
};

if (player in crew _car) then {
playMusic "";
};
};

addActionVehRadio_fnc = {
_veh = _this select 0;

_veh addEventHandler ["GetIn",{
_car = _this select 0;
_playerEntered = _this select 2;

if (_playerEntered == player) then {
_isPlaying = _car getVariable ["radioIsOn", false];

if (_isPlaying) then {
playMusic "";
playMusic [whatSong, serverTime - timeStarted];

if ((gettext (configfile >> "CfgMusic" >> whatSong >> "name") != "")) then {
[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", toUpper (gettext (configfile >> "CfgMusic" >> whatSong >> "name")), "by" + " " + (gettext (configfile >> "CfgMusic" >> whatSong >> "artist"))], true, nil, 7, 1, 0] spawn BIS_fnc_textTiles;
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

[[_car],"playSongOnRadio_fnc"] call BIS_fnc_MP;

},[nil],0,false,true,"","vehicle _this != _this && driver _target == _this && !(_target getVariable ['radioIsOn', false])"];

_veh addAction ["Turn Radio Off",{
_car = (_this select 0);

[[_car],"stopSongOnRadio_fnc"] call BIS_fnc_MP;

},[nil],0,false,true,"","vehicle _this != _this && driver _target == _this && (_target getVariable ['radioIsOn', false])"];

_veh addAction ["Resync Song",{
_car = (_this select 0);

_isPlaying = _car getVariable ["radioIsOn", false];

if (_isPlaying) then {
playMusic "";
playMusic [whatSong, serverTime - timeStarted];
} else {
playMusic "";
};

},[nil],0,false,true,"","vehicle _this != _this && _this in crew _target"];
};

player addEventHandler ["respawn", {
playMusic "";
}];

[] spawn {
if (isServer) then {
waituntil {!isNil "musicArray"};

waituntil {time > 15};

while {true} do {
{
whatSong = _x;
whatSong = configName whatSong;
timeStarted = serverTime;

publicVariable "whatSong";
publicVariable "timeStarted";

skipTrack = false;

_songInfo = [whatSong, "_"] call CBA_fnc_split;
_songLength = _songInfo select 1;
_songLength = parseNumber _songLength;

[[whatSong],"sendNewSong_fnc"] call BIS_fnc_MP;

if (!isNil "musicRadiosArray") then {
if (count musicRadiosArray > 0) then {
{
_x enableSimulationGlobal false;
_x enableSimulation false;
_x allowdamage false;
playSound3D [format ["poddy_music\music\" + whatSong + ".ogg"], _x, false, getPosASL _x, 4, 1, 50];
} foreach musicRadiosArray;
};
};

_time = time;
waituntil {
sleep 1;
time >= _time + _songLength or skipTrack
};

skipTrack = false;
} foreach musicArray;
};
};
};
