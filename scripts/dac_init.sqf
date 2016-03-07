_unit = _this select 0;

if (isServer) then {
	if (_unit in (switchableUnits + playableUnits)) then {
		waitUntil {!isNil "DAC_STRPlayers"};
		
		{
			if (isNil _x) exitWith {
				missionNamespace setVariable [_x, _unit];
				publicVariable _x;
			};
		} foreach DAC_STRPlayers;
	};
};
