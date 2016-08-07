_obj = _this select 0;

if (isServer) then {
	_obj allowDamage false;
};

_action = ["murshun_framework_reviveEveryone", "Teleport To Your Group", "", {
	_this spawn {
		_player = _this select 1;
		
		_groupUnitsFar = units (group _player) select {_x distance2d _player > 500 && !isObjectHidden _x && vehicle _x == _x};
		
		if (count _groupUnitsFar > 0) then {
			_unit = selectRandom _groupUnitsFar;
			
			_LX = (getPos _unit select 0) + (3 * sin ((getDir _unit) - 180));
			_LY = (getPos _unit select 1) + (3 * cos ((getDir _unit) - 180));
			_LZ = (getPos _unit select 2);
			
			_player setPosATL [_LX,_LY,_LZ];
		} else {
			systemChat "Group members should be at least 500m away and not in the vehicle.";
		};
	};
}, {true}] call ace_interact_menu_fnc_createAction;
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;