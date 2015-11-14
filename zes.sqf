//NOTE: Make sure Zeus module is named ZE_Zeus


//Export function
ZE_ExportEntities = {

	ZE_ObjectsExport = [];
	_mode = toLower (_this select 0);

	//Register objects to export
	switch (_mode) do {
		case "all": {
			{
				_obj = _x;
				_class = typeOf _obj;
				_pos = getPosATL _obj;
				_vec = [vectorDir _obj, vectorUp _obj];
				_sim = simulationEnabled _obj;
				_grp = group _obj;
				_pack = [_class,_pos,_vec,_sim,_grp];
				ZE_ObjectsExport = ZE_ObjectsExport + [_pack];
			} forEach (curatorEditableObjects ZE_Zeus);
		};

		case "sel": {
			{
				_obj = _x;
				if (typeName _obj == typeName objNull) Then {
					_class = typeOf _obj;
					_pos = getPosATL _obj;
					_vec = [vectorDir _obj, vectorUp _obj];
					_sim = simulationEnabled _obj;
					_grp = group _obj;
					_pack = [_class,_pos,_vec,_sim,_grp];
					ZE_ObjectsExport = ZE_ObjectsExport + [_pack];
				};
			} forEach (curatorSelected select 0);
		};
	};

	//Compile
	_compiledTxt = "//Exported with ZE";

	{
		private ["_addTxt","_codeSpawn"];
		_objArr = _x;
		_class 	= _objArr select 0;
		_pos 	= _objArr select 1;
		_vec 	= _objArr select 2;
		_sim 	= _objArr select 3;
		_grp 	= _objArr select 4;
		if (isNull _grp) Then {
			_codeSpawn = format ["
_object = createVehicle [""%1"", [0,0,0], [], 0, ""CAN_COLLIDE""];",_class];
		} else {
			_side = side _grp;
			_codeSpawn = format ["
_object = createGroup %2 createUnit [""%1"", [0,0,0], [], 0, ""NONE""];",_class,_side];
		};

		if (_sim) Then {
			_addTxt = _codeSpawn + format ["
_object setPosATL %2;
_object setVectorDirAndUp %3;
", _class, _pos, _vec];
		} else {
			_addTxt = _codeSpawn + format ["
_object enableSimulation %4;
_object setPosATL %2;
_object setVectorDirAndUp %3;
", _class, _pos, _vec, _sim];
		};


		_compiledTxt = _compiledTxt + _addTxt;
	} forEach ZE_ObjectsExport;

	copyToClipboard _compiledTxt;

};

//Enable editing function
ZE_AddCuratorObjects = {
	_nearObjs = (getPos curatorCamera) nearObjects 25;
	ZE_Zeus addCuratorEditableObjects [_nearObjs,false];
};

//Handle Object simulation
ZE_ObjectSimulation = {
	_mode = toLower (_this select 0);
	switch (_mode) do {
		case "enable": {
			{_x enableSimulation true} forEach (curatorSelected select 0);
		};
		case "disable": {
			{_x enableSimulation false} forEach (curatorSelected select 0);
		};
	};
};


//Key Stroke Handler
key_ctrl = 29;
key_shift = 42;
key_c = 46;
key_a = 30;
key_e = 18;
key_s = 31;

pressed_ctrl = false;
pressed_shift = false;
pressed_c = false;
pressed_a = false;
pressed_e = false;
pressed_s = false;

//Add Keystroke EH
ZE_AddKeyStrokeEH = {
	ZE_keyDownEHId = findDisplay 312 displayAddEventHandler ["KeyDown",{
		if (_this select 1 == key_ctrl) then {pressed_ctrl = true;};
		if (_this select 1 == key_shift) then {pressed_shift = true;};
		if (_this select 1 == key_c) then {pressed_c = true;};
		if (_this select 1 == key_a) then {pressed_a = true;};
		if (_this select 1 == key_e) then {pressed_e = true;};
		if (_this select 1 == key_s) then {pressed_s = true;};
	}];
	ZE_keyUpEHId = findDisplay 312 displayAddEventHandler ["KeyUp",{
		if (_this select 1 == key_ctrl) then {pressed_ctrl = false;};
		if (_this select 1 == key_shift) then {pressed_shift = false;};
		if (_this select 1 == key_c) then {pressed_c = false;};
		if (_this select 1 == key_a) then {pressed_a = false;};
		if (_this select 1 == key_e) then {pressed_e = false;};
		if (_this select 1 == key_s) then {pressed_s = false;};
	}];

	["ZE_KeyStroke", "onEachFrame", {
		if (pressed_ctrl && pressed_a) ExitWith {
			["ALL"] call ZE_ExportEntities;
			hint "";
			["CuratorAddAddons",["ZEUS objects copied to clipboard."]] calL BIS_fnc_showNotification;
			pressed_a = false;
		};
		if (pressed_ctrl && pressed_c) ExitWith {
			["SEL"] call ZE_ExportEntities;
			["CuratorAddAddons",["SELETED objects copied to clipboard."]] calL BIS_fnc_showNotification;
			pressed_c = false;
		};
		if (pressed_ctrl && pressed_shift && pressed_e) ExitWith {
			[] call ZE_AddCuratorObjects;
			["CuratorAddAddons",["Nearby objects ENABLED for Zeus."]] calL BIS_fnc_showNotification;
			pressed_e = false;
		};
		if (pressed_ctrl && pressed_shift && pressed_s) ExitWith {
			["DISABLE"] call ZE_ObjectSimulation;
			["CuratorAddAddons",["DISABLED simulation for selected objects."]] calL BIS_fnc_showNotification;
			pressed_s = false;
		};
		if (pressed_ctrl && pressed_s) ExitWith {
			["ENABLE"] call ZE_ObjectSimulation;
			["CuratorAddAddons",["ENABLED simulation for selected objects."]] calL BIS_fnc_showNotification;
			pressed_s = false;
		};
	}] call BIS_fnc_addStackedEventHandler;

};

//Remove Keystroke EH
ZE_RemoveKeyStrokeEH = {
	findDisplay 312 displayRemoveEventHandler ["KeyDown",ZE_keyDownEHId];
	findDisplay 312 displayRemoveEventHandler ["KeyUp",ZE_keyUpEHId];

	["ZE_KeyStroke", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
};



//Handle enable/disable of EH on Zeus start/end
[] spawn {
	while {true} do {
		waitUntil {sleep 0.1; !(isNull findDisplay 312)};
		[] spawn ZE_AddKeyStrokeEH;
		waitUntil {sleep 0.1; isNull findDisplay 312};
		[] spawn ZE_RemoveKeyStrokeEH;
	};
};