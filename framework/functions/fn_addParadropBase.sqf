_obj = _this select 0;

if (isServer) then {
	_obj allowDamage false;
};

_action = ["murshun_framework_reviveEveryone", "Paradrop To Your Group", "", {
	_this spawn {
		_player = _this select 1;
		
		_groupUnitsFar = units (group _player) select {_x distance2d _player > 1};
		
		if (count _groupUnitsFar > 0) then {
			_dropPos = getPosATL selectRandom _groupUnitsFar;
			
			_parachute = createVehicle ["Steerable_Parachute_F", [_dropPos select 0, _dropPos select 1, (_dropPos select 2) + 250], [], 0, "NONE"];
			_player moveInDriver _parachute;
		} else {
			systemChat "Either you're alone in the group or everyone is too close.";
		};
	};
}, {true}] call ace_interact_menu_fnc_createAction;
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
