_obj = _this select 0;

if (isServer) then {
	_obj allowDamage false;
};

_action = ["murshun_framework_reviveEveryone", "Revive Everyone (At This Base)", "", {
	_this spawn {
		_player = _this select 1;
		_pos = getPos _player;
		
		systemChat "Spectators will respawn in 5 seconds.";
		
		sleep 5;
		
		[_pos] spawn murshun_spectator_reviveAllPlayers_fnc;
		
		systemChat "Spectator respawn is done.";
	};
}, {true}] call ace_interact_menu_fnc_createAction;
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
