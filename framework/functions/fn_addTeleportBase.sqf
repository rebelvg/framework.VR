_obj = _this select 0;

if (isServer) then {
	_obj allowDamage false;
};

_action = ["murshun_framework_teleport", "Teleport To Your Team", "", {
	_this spawn {
		_player = _this select 1;
		
		_groupUnitsFar = allPlayers select {side _x == side _player && _x distance2d _player > 100 && !isObjectHidden _x && (vehicle _x == _x or (vehicle _x) emptyPositions "cargo" == 0)};
		
		if (count _groupUnitsFar > 0) then {
			_unit = selectRandom _groupUnitsFar;
			
			if (vehicle _unit == _unit) then {
				_LX = (getPos _unit select 0) + (3 * sin ((getDir _unit) - 180));
				_LY = (getPos _unit select 1) + (3 * cos ((getDir _unit) - 180));
				_LZ = (getPos _unit select 2);
				
				_player setPosATL [_LX,_LY,_LZ];
			} else {
				_player moveInCargo vehicle _unit;
			};
		} else {
			systemChat "Team members should be at least 100m away and not in a full vehicle.";
		};
	};
}, {true}] call ace_interact_menu_fnc_createAction;
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
