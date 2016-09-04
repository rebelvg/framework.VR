murshun_sendNewSong_fnc = {
	if ((vehicle player) getVariable ['murshun_radioIsOn', false]) then {
		playMusic "";
		playMusic murshun_whatSong;
	};
};

murshun_playSongOnRadio_fnc = {
	_vehicle = _this select 0;

	if (isServer) then {
		_vehicle setVariable ["murshun_radioIsOn", true, true];
	};

	if (player in crew _vehicle) then {
		playMusic "";
		playMusic [murshun_whatSong, time - murshun_timeStarted];
	};
};

murshun_stopSongOnRadio_fnc = {
	_vehicle = _this select 0;

	if (isServer) then {
		_vehicle setVariable ["murshun_radioIsOn", false, true];
	};

	if (player in crew _vehicle) then {
		playMusic "";
	};
};

murshun_removeRadio_fnc = {
	_radio = _this select 0;

	_radio setVariable ["murshun_loudRadioIsOn", false, true];
	deleteVehicle (_radio getVariable ["murshun_hiddenRadio", nil]);
};

murshun_createRadio_fnc = {
	_radio = _this select 0;
	_hiddenRadio = "Land_FMradio_F" createVehicle [0, 0, 0];
	
	[[_hiddenRadio, true], "hideObjectGlobal", false] call BIS_fnc_MP;
	hideObject _hiddenRadio;
	_hiddenRadio allowDamage false;

	_hiddenRadio setPosATL getPosATL _radio;
	_hiddenRadio attachTo [_radio, [0, 0, 0]];
	_radio setVariable ["murshun_hiddenRadio", _hiddenRadio, true];
	
	if (_radio isKindOf "air") then {
		[[_hiddenRadio, "loud_" + murshun_whatSong], "say3d"] call BIS_fnc_MP;
	} else {
		[[_hiddenRadio, murshun_whatSong], "say3d"] call BIS_fnc_MP;
	};
};

KK_fnc_arrayShufflePlus = {
	private ["_arr", "_cnt"];
	
	_arr = _this select 0;
	_cnt = count _arr;
	
	for "_i" from 1 to (_this select 1) do {
		_arr pushBack (_arr deleteAt floor random _cnt);
	};
	
	_arr
};

if (isNil "murshun_musicRadiosArray") then {
	murshun_musicRadiosArray = [];
};

if (isNil "murshun_whatSong") then {
	murshun_whatSong = "";
};

if (isNil "murshun_timeStarted") then {
	murshun_timeStarted = 0;
};

[] spawn {
	if (!hasInterface) exitWith {};

	waitUntil {!isNull player};
	
	player addEventHandler ["Respawn", {
		playMusic "";
	}];
};

[] spawn {
	if (!isServer) exitWith {};
	
	waitUntil {time > 15};
	
	_musicArray = [];
	
	if (!isNil "murshun_radioSongs") then {
		if (count murshun_radioSongs != 0) then {
			_musicArray = murshun_radioSongs;
		};
	};
	
	if (count _musicArray == 0) then {
		if (!isNil "murshun_radioThemes") then {
			if (count murshun_radioThemes != 0) then {
				{
					if (count _x != 0) then {
						_searchString = format ["gettext (_x >> 'theme') == '%1'", _x];
						_musicArray = _musicArray + (_searchString configClasses (configFile >> "CfgMusic"));
					};
				} foreach murshun_radioThemes;
				
				_musicArray = _musicArray apply {configName _x};
			};
		};
	};
	
	if (count _musicArray == 0) then {
		_musicArray = "true" configClasses (configFile >> "CfgMusic");
		
		_musicArray = _musicArray apply {configName _x};
	};
	
	_musicArray = _musicArray select {getText (configFile >> "CfgMusic" >> _x >> "tag") == "Poddy Music"};
	
	if (count _musicArray == 0) exitWith {};
	
	murshun_radioSongs = _musicArray;
	
	while {true} do {
		murshun_radioSongs = [murshun_radioSongs, 4 * count murshun_radioSongs] call KK_fnc_arrayShufflePlus;
		
		{
			murshun_whatSong = _x;
			murshun_timeStarted = time;
			
			publicVariable "murshun_whatSong";
			publicVariable "murshun_timeStarted";
			
			_songInfo = [murshun_whatSong, "_"] call CBA_fnc_split;
			_songLength = _songInfo select 1;
			_songLength = parseNumber _songLength;
			
			[[], "murshun_sendNewSong_fnc"] call BIS_fnc_MP;
			
			{
				deleteVehicle (_x getVariable ["murshun_hiddenRadio", nil]);
				
				if (alive _x && _x getVariable ["murshun_loudRadioIsOn", false]) then {
					[_x] spawn murshun_createRadio_fnc;
				};
			} foreach murshun_musicRadiosArray;
			
			sleep _songLength;
		} foreach murshun_radioSongs;
	};	
};
