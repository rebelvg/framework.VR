waitUntil {time > 0};

{
if (leader _x != _x) then {
_LX = (getPosATL _x select 0) + ((getPosATL leader _x select 0) - (getPosATL _x select 0))/1.5;
_LZ = (getPosATL _x select 1) + ((getPosATL leader _x select 1) - (getPosATL _x select 1))/1.5;
_LY = (getPosATL leader _x select 2);

_x setPosATL [_LX, _LZ, _LY];
};
} foreach (switchableUnits + playableUnits);
