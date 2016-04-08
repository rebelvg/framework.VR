murshun_sendNewSong_fnc = {
	_car = vehicle player;
	_song = _this select 0;

	if (player in crew _car && vehicle player != player && (_car getVariable ['murshun_radioIsOn', false])) then {
		playMusic "";
		playMusic _song;

		if ((gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "name") != "")) then {
			[parseText format ["<t font='PuristaBold' shadow='2' align='right' size='1.6'>""%1""</t><br /><t shadow='2' align='right' size='1.4'>%2</t>", toUpper (gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "name")), "by" + " " + (gettext (configfile >> "CfgMusic" >> murshun_whatSong >> "artist"))], true, nil, 7, 1, 0] spawn BIS_fnc_textTiles;
		};
	};
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

murshun_stopSongOnRadio_fnc = {
	_car = _this select 0;

	if (isServer) then {
		_car setVariable ["murshun_radioIsOn", false, true];
	};

	if (player in crew _car) then {
		playMusic "";
	};
};

KK_fnc_arrayShufflePlus = {
	private ["_arr","_cnt"];
	_arr = _this select 0;
	_cnt = count _arr;
	for "_i" from 1 to (_this select 1) do {
		_arr pushBack (_arr deleteAt floor random _cnt);
	};
	
	_arr
};

murshun_musicRadiosArray = [];

if (isNil "murshun_whatSong") then {
	murshun_whatSong = "";
};

if (isNil "murshun_timeStarted") then {
	murshun_timeStarted = 0;
};

player addEventHandler ["Respawn", {
	playMusic "";
}];

if (isServer) then {	
	waitUntil {time > 15};
	
	while {true} do {
		_musicArray = "gettext (_x >> 'tag') == 'Poddy Music'" configClasses (configFile >> "CfgMusic");
		_musicArray = [_musicArray, 4 * count _musicArray] call KK_fnc_arrayShufflePlus;
		
		{
			murshun_whatSong = _x;
			murshun_whatSong = configName murshun_whatSong;
			murshun_timeStarted = time;
			
			publicVariable "murshun_whatSong";
			publicVariable "murshun_timeStarted";
			
			_songInfo = [murshun_whatSong, "_"] call CBA_fnc_split;
			_songLength = _songInfo select 1;
			_songLength = parseNumber _songLength;
			
			[[murshun_whatSong], "murshun_sendNewSong_fnc"] call BIS_fnc_MP;
			
			{
				deleteVehicle (_x getVariable ["radio_object", nil]);
				
				if (alive _x) then {
					_radio = "Land_FMradio_F" createVehicle [0, 0, 0];
					
					if (_x getVariable ["radio_playing", false]) then {
						_radio setPosATL getPosATL _x;
						_radio attachTo [_x, [0, 0, 0]];
						_x setVariable ["radio_object", _radio, true];
					} else {
						_x setVariable ["radio_object", _radio, true];
					};
					
					hideObject _radio;
					hideObjectGlobal _radio;
					_radio allowDamage false;
					
					[[_radio, murshun_whatSong], "say3d"] call BIS_fnc_MP;
				};
			} foreach murshun_musicRadiosArray;
			
			murshun_skipTrack = false;
			
			_time = time;
			waituntil {
				sleep 1;
				time >= _time + _songLength or murshun_skipTrack
			};
			
			murshun_skipTrack = false;
		} foreach _musicArray;
	};	
};
