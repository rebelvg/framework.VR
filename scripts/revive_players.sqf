_obj = _this select 0;

waitUntil {!isNil "murshun_frameworkInit"};

if (isServer) then {
	_obj allowDamage false;
};

_action = ["murshun_framework_reviveEveryone", "Revive Everyone (At This Base)", "", {
	_this spawn {
		_player = _this select 1;
		_newPos = getPos _player findEmptyPosition [0, 20];
		
		if (count _newPos == 0) then {
			_newPos = getPos _player;
		};
		
		"base_marker" setMarkerPos _newPos;
		
		systemChat "Players will respawn in 5 seconds.";
		
		sleep 5;
		
		[] spawn murshun_spectator_reviveAllPlayers_fnc;
	};
}, {(tolower gettext (configFile >> "cfgVehicles" >> typeOf player >> "displayName") == "officer") || (tolower gettext (configFile >> "cfgVehicles" >> typeOf player >> "displayName") == "squad leader")}] call ace_interact_menu_fnc_createAction;
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
