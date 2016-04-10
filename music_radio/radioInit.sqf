_radio = _this select 0;
_enabledOnStart = _this select 1;

waitUntil {!isnil "murshun_musicRadiosArray"};

if (isNil "_enabledOnStart") then {
	_enabledOnStart = false;
};

if (_radio isKindOf "thing" or _enabledOnStart) then {
	if (isServer) then {
		_radio setVariable ["radio_playing", true, true];
	};
	
	_action = ["murshun_radio_turnRadioOff", "Turn Radio Off", "", {
		_radio = _this select 0;
		
		_trueRadio = _radio getVariable ["radio_object", nil];
		_radio setVariable ["radio_playing", false, true];
		
		detach _trueRadio;
		_trueRadio setPosATL [0, 0, 0];
	}, {
		_radio = _this select 0;
		
		_isPlaying = _radio getVariable ["radio_playing", false];
		
		_isPlaying
	}] call ace_interact_menu_fnc_createAction;
	[_radio, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["murshun_radio_turnRadioOn", "Turn Radio On", "", {
		_radio = _this select 0;
		
		_trueRadio = _radio getVariable ["radio_object", nil];
		_radio setVariable ["radio_playing", true, true];
		
		_trueRadio setPosATL getPosATL _radio;
		_trueRadio attachTo [_radio, [0, 0, 0]];
	}, {
		_radio = _this select 0;
		
		_isPlaying = _radio getVariable ["radio_playing", true];
		
		!_isPlaying
	}] call ace_interact_menu_fnc_createAction;
	[_radio, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	
	murshun_musicRadiosArray = murshun_musicRadiosArray + [_radio];
} else {
	if (_radio isKindOf "air" || _radio isKindOf "ship") then {
		if (isServer) then {
			_radio setVariable ["radio_playing", false, true];
		};
		
		_action = ["murshun_radio_turnRadioOff", "Turn Radio Off", "", {
			_radio = _this select 0;
			
			_trueRadio = _radio getVariable ["radio_object", nil];
			_radio setVariable ["radio_playing", false, true];
			
			detach _trueRadio;
			_trueRadio setPosATL [0, 0, 0];
		}, {
			_radio = _this select 0;
			_player = _this select 1;
			
			_isPlaying = _radio getVariable ["radio_playing", false];
			
			_isPlaying && driver _radio == _player
		}] call ace_interact_menu_fnc_createAction;
		[_radio, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["murshun_radio_turnRadioOn", "Turn Radio On", "", {
			_radio = _this select 0;
			
			_trueRadio = _radio getVariable ["radio_object", nil];
			_radio setVariable ["radio_playing", true, true];
			
			_trueRadio setPosATL getPosATL _radio;
			_trueRadio attachTo [_radio, [0, 0, 0]];
		}, {
			_radio = _this select 0;
			_player = _this select 1;
			
			_isPlaying = _radio getVariable ["radio_playing", true];
			
			!_isPlaying && driver _radio == _player
		}] call ace_interact_menu_fnc_createAction;
		[_radio, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
		
		murshun_musicRadiosArray = murshun_musicRadiosArray + [_radio];
	} else {
		if (isServer) then {
			_radio setVariable ["murshun_radioIsOn", false, true];
			
			_radio addMPEventHandler ["MPKilled", {
				_car = _this select 0;

				[[_car], "murshun_stopSongOnRadio_fnc"] call BIS_fnc_MP;
			}];
		};

		_radio addEventHandler ["GetIn", {
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
		
		_radio addEventHandler ["GetOut", {
			_playerExited = _this select 2;

			if (_playerExited == player) then {
				playMusic "";
			};
		}];
		
		_action = ["murshun_radio_turnRadioOff", "Turn Radio Off", "", {
			_radio = _this select 0;
			
			[[_radio], "murshun_stopSongOnRadio_fnc"] call BIS_fnc_MP;
		}, {
			_radio = _this select 0;
			_player = _this select 1;
			
			_isPlaying = _radio getVariable ["murshun_radioIsOn", false];
			
			_isPlaying && driver _radio == _player
		}] call ace_interact_menu_fnc_createAction;
		[_radio, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["murshun_radio_turnRadioOn", "Turn Radio On", "", {
			_radio = _this select 0;
			
			[[_radio], "murshun_playSongOnRadio_fnc"] call BIS_fnc_MP;
		}, {
			_radio = _this select 0;
			_player = _this select 1;
			
			_isPlaying = _radio getVariable ["murshun_radioIsOn", true];
			
			!_isPlaying && driver _radio == _player
		}] call ace_interact_menu_fnc_createAction;
		[_radio, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	};
};
