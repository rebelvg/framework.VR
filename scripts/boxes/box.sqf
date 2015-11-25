_unit = (_this select 0);

waituntil {!isNil "loadoutArray"};

_loadoutArray = loadoutArray;

if (!isServer) exitWith {};
clearMagazineCargoGlobal _unit;
clearWeaponCargoGlobal _unit;
clearitemcargoGlobal _unit;
clearBackpackCargoGlobal _unit;

_unit allowDamage false;

if (!isMultiplayer) then {
_unit addAction ["Virtual Arsenal",{["Open",true] call BIS_fnc_arsenal}];
};

_rifleArray = ((_loadoutArray select 8) call BIS_fnc_selectRandom);
_rifle = _rifleArray select 0;
_rifleMags = _rifleArray select 1;
_rifleDevices = _rifleArray select 2;

_glRifleArray = (_loadoutArray select 9);
_glRifle = _glRifleArray select 0;
_glRifleMags = _glRifleArray select 1;
_glGrenade = _glRifleArray select 2;
_glRifleDevices = _glRifleArray select 3;

_allRifleMags = [];

_riflesArray = (_loadoutArray select 8);
{
_allRifleMags = _allRifleMags + [_x select 1];
} foreach _riflesArray;

_allRifleMags = _allRifleMags + [_glRifleMags];

_MGArray = (_loadoutArray select 10);
_MG = _MGArray select 0;
_MGMags = _MGArray select 1;
_MGDevices = _MGArray select 2;

_marksmanRifleArray = (_loadoutArray select 11);
_marksmanRifle = _marksmanRifleArray select 0;
_marksmanMags = _marksmanRifleArray select 1;
_marksmanDevices = _marksmanRifleArray select 2;

_atSingleShot = (_loadoutArray select 12);

_atReloadableArray = (_loadoutArray select 13);
_atReloadable = _atReloadableArray select 0;
_atMags = _atReloadableArray select 1;
_atDevices = _atReloadableArray select 2;

_aaArray = (_loadoutArray select 14);
_aa = _aaArray select 0;
_aaMags = _aaArray select 1;

_grenadesArray = (_loadoutArray select 15);
_lethalGrenades = _grenadesArray select 0;
_nonLethalGrenades = _grenadesArray select 1;

_handgunArray = (_loadoutArray select 16);
_handgun = _handgunArray select 0;
_handgunMags = _handgunArray select 1;
_handgunDevices = _handgunArray select 2;

_unit addItemCargoGlobal ["ToolKit", 1];

if (!(_atSingleShot isEqualTo "")) then {
_unit addWeaponCargoGlobal [_atSingleShot, 20];
};

{
if (!(_x isEqualTo "")) then {
_unit addMagazineCargoGlobal [_x, 100];
};
} foreach _allRifleMags;

if (!(_MGMags isEqualTo "")) then {
_unit addMagazineCargoGlobal [_MGMags, 50];
};

if (!(_marksmanMags isEqualTo "")) then {
_unit addMagazineCargoGlobal [_marksmanMags, 25];
};

if (!(_glGrenade isEqualTo "")) then {
_unit addMagazineCargoGlobal [_glGrenade, 40];
};

if (!(_handgunMags isEqualTo "")) then {
_unit addMagazineCargoGlobal [_handgunMags, 20];
};

if (!(_atMags isEqualTo "")) then {
_unit addMagazineCargoGlobal [_atMags, 20];
};

if (!(_aaMags isEqualTo "")) then {
_unit addMagazineCargoGlobal [_aaMags, 20];
};

{
_unit addItemCargoGlobal [_x, 40];
} foreach _lethalGrenades;
{
_unit addItemCargoGlobal [_x, 200];
} foreach _nonLethalGrenades;
_unit addItemCargoGlobal ["DemoCharge_Remote_Mag", 30];
_unit addItemCargoGlobal ["SatchelCharge_Remote_Mag", 10];

_unit addItemCargoGlobal ["ACE_wirecutter", 2];
_unit addItemCargoGlobal ["ACE_SpareBarrel", 2];
_unit addItemCargoGlobal ["ACE_CableTie", 30];
_unit addItemCargoGlobal ["EWK_Cig1", 100];
