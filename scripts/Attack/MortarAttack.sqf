if (!isServer) exitWith {};
// ["MARKERNAME", numberofrounds, sleep, radius, "round type"] spawn fnc_MortarAttack;
//["Home", 2, 2, "Sh_82mm_AMOS"] spawn fnc_MortarAttack;
//Sh_82mm_AMOS_guided
fnc_MortarAttack = {
	_marker = _this select 0;
	_number = _this select 1;
	_sleep = _this select 2;
	_radius = _this select 3;
	_round = _this select 4;
	
	for "_i" from 0 to floor _number do 
	{
		_psn = [getMarkerPos _marker, _radius * sqrt random 1, random 360] call BIS_fnc_relPos;
		_psn set [2, (_psn select 2) + 100];
		_mortar = createVehicle [_round, [0,0,0], [], 0, "FLY"];
		_mortar setPos _psn;
		_mortar setVelocity [0,0,-15];
		sleep _sleep;
	};	
};
