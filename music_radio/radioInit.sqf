_radio = _this select 0;

waitUntil {!isNil "murshun_radioInit"};

if (_radio isKindOf "thing" or _radio isKindOf "static") then {
	if (isServer) then {
		murshun_musicRadiosArray = murshun_musicRadiosArray + [_radio];
		
		_radio setVariable ["murshun_loudRadioIsOn", true, true];
	};
	
	_action = ["murshun_radio_turnRadioOff", "Turn Radio Off", "", {
		_radio = _this select 0;

		[_radio] spawn murshun_removeRadio_fnc;
	}, {
		_radio = _this select 0;
		
		_isPlaying = _radio getVariable ["murshun_loudRadioIsOn", false];
		
		_isPlaying
	}] call ace_interact_menu_fnc_createAction;
	[_radio, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["murshun_radio_turnRadioOn", "Turn Radio On", "", {
		_radio = _this select 0;		

		_radio setVariable ["murshun_loudRadioIsOn", true, true];		
		[_radio] spawn murshun_createRadio_fnc;
	}, {
		_radio = _this select 0;
		
		_isPlaying = _radio getVariable ["murshun_loudRadioIsOn", true];
		
		!_isPlaying
	}] call ace_interact_menu_fnc_createAction;
	[_radio, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
} else {
	if (isServer) then {
		murshun_musicRadiosArray = murshun_musicRadiosArray + [_radio];
		
		_radio setVariable ["murshun_radioIsOn", false, true];
		_radio setVariable ["murshun_loudRadioIsOn", false, true];
		
		_radio addMPEventHandler ["MPKilled", {
			_radio = _this select 0;

			[[_radio], "murshun_stopSongOnRadio_fnc"] call BIS_fnc_MP;			

			[_radio] spawn murshun_removeRadio_fnc;
		}];
	};

	_radio addEventHandler ["GetIn", {
		_radio = _this select 0;
		_playerEntered = _this select 2;

		if (_playerEntered == player) then {
			if (_radio getVariable ["murshun_radioIsOn", false]) then {
				playMusic "";
				playMusic [murshun_whatSong, time - murshun_timeStarted];
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

		[_radio] spawn murshun_removeRadio_fnc;
		
		[[_radio], "murshun_playSongOnRadio_fnc"] call BIS_fnc_MP;
	}, {
		_radio = _this select 0;
		_player = _this select 1;
		
		_isPlaying = _radio getVariable ["murshun_radioIsOn", true];
		
		!_isPlaying && driver _radio == _player
	}] call ace_interact_menu_fnc_createAction;
	[_radio, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	
	_action = ["murshun_radio_turnRadioOff", "Turn Loudspeaker Off", "", {
		_radio = _this select 0;
		
		[_radio] spawn murshun_removeRadio_fnc;
	}, {
		_radio = _this select 0;
		_player = _this select 1;
		
		_isPlaying = _radio getVariable ["murshun_loudRadioIsOn", false];
		
		_isPlaying && driver _radio == _player
	}] call ace_interact_menu_fnc_createAction;
	[_radio, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["murshun_radio_turnRadioOn", "Turn Loudspeaker On", "", {
		_radio = _this select 0;
		
		[[_radio], "murshun_stopSongOnRadio_fnc"] call BIS_fnc_MP;
		
		_radio setVariable ["murshun_loudRadioIsOn", true, true];		
		[_radio] spawn murshun_createRadio_fnc;
	}, {
		_radio = _this select 0;
		_player = _this select 1;
		
		_isPlaying = _radio getVariable ["murshun_loudRadioIsOn", true];
		
		!_isPlaying && driver _radio == _player
	}] call ace_interact_menu_fnc_createAction;
	[_radio, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;	
};
