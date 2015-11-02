_unit = _this select 0;
_className = _this select 1;

waituntil {!isNil "loadoutArray_east"};

_loadoutArray = loadoutArray_east;

if (count _loadoutArray == 0) exitWith {};

_loadoutUniform = "";
_loadoutVest = "";
_loadoutHeadgear = "";
_loadoutBackpack = "";
_loadoutFacewear = "";

_loadoutMainWeapon = "";
_loadoutHandgunWeapon = "";
_loadoutLauncherWeapon = "";

_loadoutMainWeaponDevices = "";
_loadoutHandgunWeaponDevices = "";
_loadoutLauncherWeaponDevices = "";

_loadoutMainWeaponMags = "";
_loadoutHandgunWeaponMags = "";
_loadoutLauncherWeaponMags = "";
_loadoutMainWeaponGlGrenades = "";

_loadoutBinoculars = "";

removeAllAssignedItems _unit;
removeAllWeapons _unit;
removeBackpack _unit;
removeAllItems _unit;
removeGoggles _unit;
removeUniform _unit;
removeVest _unit;
removeHeadgear _unit;

_uniform = ((_loadoutArray select 0) call BIS_fnc_selectRandom);
_vest = ((_loadoutArray select 1) call BIS_fnc_selectRandom);
_headgear = ((_loadoutArray select 2) call BIS_fnc_selectRandom);
_backpack = ((_loadoutArray select 3) call BIS_fnc_selectRandom);
_radioBackpack = (_loadoutArray select 4);
_facewear = ((_loadoutArray select 5) call BIS_fnc_selectRandom);
_items = (_loadoutArray select 6);
_linkItems = (_loadoutArray select 7);

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
_handGrenade = _grenadesArray select 0;
_smokeGrenade = _grenadesArray select 1;

_handgunArray = (_loadoutArray select 16);
_handgun = _handgunArray select 0;
_handgunMags = _handgunArray select 1;
_handgunDevices = _handgunArray select 2;

_binoculars = (_loadoutArray select 17);

switch (_className) do {
	case "squad leader": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	if (!(_radioBackpack isEqualTo "")) then {
	_loadoutBackpack = _radioBackpack;
	} else {
	//_loadoutBackpack = _backpack;
	};
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _glRifle;
	_loadoutMainWeaponDevices = _glRifleDevices;
	_loadoutMainWeaponMags = _glRifleMags;
	_loadoutMainWeaponGlGrenades = _glGrenade;
	_loadoutHandgunWeapon = _handgun;
	_loadoutHandgunWeaponDevices = _handgunDevices;
	_loadoutHandgunWeaponMags = _handgunMags;
	
	_loadoutBinoculars = _binoculars;
	};
	
	case "team leader": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	//_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _glRifle;
	_loadoutMainWeaponDevices = _glRifleDevices;
	_loadoutMainWeaponMags = _glRifleMags;
	_loadoutMainWeaponGlGrenades = _glGrenade;
	_loadoutHandgunWeapon = _handgun;
	_loadoutHandgunWeaponDevices = _handgunDevices;
	_loadoutHandgunWeaponMags = _handgunMags;
	
	_loadoutBinoculars = _binoculars;
	};
	
	case "combat life saver": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _rifle;
	_loadoutMainWeaponDevices = _rifleDevices;
	_loadoutMainWeaponMags = _rifleMags;
	};
	
	case "autorifleman": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	//_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _MG;
	_loadoutMainWeaponDevices = _mgDevices;
	_loadoutMainWeaponMags = _MGMags;
	};
	
	case "rifleman (at)": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	//_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _rifle;
	_loadoutMainWeaponDevices = _rifleDevices;
	_loadoutMainWeaponMags = _rifleMags;
	_loadoutLauncherWeapon = _atSingleShot;
	};
	
	case "missile specialist (at)": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _rifle;
	_loadoutMainWeaponDevices = _rifleDevices;
	_loadoutMainWeaponMags = _rifleMags;
	_loadoutLauncherWeapon = _atReloadable;
	_loadoutLauncherWeaponDevices = _atDevices;
	_loadoutLauncherWeaponMags = _atMags;
	};
	
	case "rifleman": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	//_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _rifle;
	_loadoutMainWeaponDevices = _rifleDevices;
	_loadoutMainWeaponMags = _rifleMags;
	};
	
	case "engineer": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _rifle;
	_loadoutMainWeaponDevices = _rifleDevices;
	_loadoutMainWeaponMags = _rifleMags;
	};
	
	case "marksman": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	//_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _marksmanRifle;
	_loadoutMainWeaponDevices = _marksmanDevices;
	_loadoutMainWeaponMags = _marksmanMags;
	};
	
	case "grenadier": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	//_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _glRifle;
	_loadoutMainWeaponDevices = _glRifleDevices;
	_loadoutMainWeaponMags = _glRifleMags;
	_loadoutMainWeaponGlGrenades = _glGrenade;
	};
	
	case "missile specialist (aa)": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _rifle;
	_loadoutMainWeaponDevices = _rifleDevices;
	_loadoutMainWeaponMags = _rifleMags;
	_loadoutLauncherWeapon = _aa;
	_loadoutLauncherWeaponMags = _aaMags;
	};
	
	case "ammo bearer": {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _rifle;
	_loadoutMainWeaponDevices = _rifleDevices;
	_loadoutMainWeaponMags = _rifleMags;
	};
	
	default {
	_loadoutUniform = _uniform;
	_loadoutVest = _vest;
	_loadoutHeadgear = _headgear;
	//_loadoutBackpack = _backpack;
	_loadoutFacewear = _facewear;

	_loadoutMainWeapon = _rifle;
	_loadoutMainWeaponDevices = _rifleDevices;
	_loadoutMainWeaponMags = _rifleMags;
	
	systemchat "Wrong loadout classname, falling back to rifleman.";
	};
};

_unit forceAddUniform _loadoutUniform;
_unit addVest _loadoutVest;
_unit addHeadgear _loadoutHeadgear;
_unit addBackpack _loadoutBackpack;
_unit addGoggles _loadoutFacewear;

for "_i" from 1 to 10 do {_unit addItem "ACE_elasticBandage";};
for "_i" from 1 to 10 do {_unit addItem "ACE_quikclot";};
for "_i" from 1 to 4 do {_unit addItem "ACE_morphine";};
for "_i" from 1 to 2 do {_unit addItem "ACE_epinephrine";};
for "_i" from 1 to 1 do {_unit addItem "ACE_atropine";};
for "_i" from 1 to 1 do {_unit addItem "ACE_tourniquet";};

if (!(_smokeGrenade isEqualTo "")) then {
for "_i" from 1 to 1 do {_unit addItem _smokeGrenade;};
};

switch (_className) do {
	case "squad leader": {
	_items = _items + ["murshun_cigs_lighter"];
	};
	
	case "team leader": {
	_items = _items + ["murshun_cigs_lighter"];
	};
	
	case "combat life saver": {
	_items = _items + ["murshun_cigs_matches"];

	for "_i" from 1 to 15 do {_unit addItem "ACE_elasticBandage";};
	for "_i" from 1 to 15 do {_unit addItem "ACE_quikclot";};
	for "_i" from 1 to 10 do {_unit addItem "ACE_morphine";};
	for "_i" from 1 to 10 do {_unit addItem "ACE_epinephrine";};
	for "_i" from 1 to 10 do {_unit addItem "ACE_atropine";};
	for "_i" from 1 to 5 do {_unit addItem "ACE_tourniquet";};
	for "_i" from 1 to 5 do {_unit addItem "ACE_salineIV_500";};
	for "_i" from 1 to 3 do {_unit addItem "ACE_personalAidKit";};
	};
	
	case "autorifleman": {
	_items = _items + ["murshun_cigs_matches"];
	};
	
	case "rifleman (at)": {
	_items = _items + ["murshun_cigs_matches"];
	};
	
	case "missile specialist (at)": {
	_items = _items + ["murshun_cigs_matches"];
	};
	
	case "rifleman": {
	_items = _items + ["murshun_cigs_matches"];
	};
	
	case "engineer": {
	_items = _items + ["murshun_cigs_matches"];
	
	_unit addItem "ACE_M26_Clacker";
	_unit addItem "ACE_DefusalKit";
	for "_i" from 1 to 2 do {_unit addItem "DemoCharge_Remote_Mag";};
	};
	
	case "marksman": {
	_items = _items + ["murshun_cigs_matches"];
	};
	
	case "grenadier": {
	_items = _items + ["murshun_cigs_matches"];
	};
	
	case "missile specialist (aa)": {
	_items = _items + ["murshun_cigs_matches"];
	};
	
	case "ammo bearer": {
	_items = _items + ["murshun_cigs_matches"];

	_unit addMagazines [_MGMags, 2];
	};
	
	default {
	_items = _items + ["murshun_cigs_matches"];
	};
};

{
	_unit addItem _x;
} foreach _items;

{
	_unit linkItem _x;
} foreach _linkItems;

if (!(_loadoutMainWeapon isEqualTo "")) then {
	_unit addWeapon _loadoutMainWeapon;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _loadoutMainWeaponDevices;
	_unit addMagazines [_loadoutMainWeaponMags, 8];
	if (_loadoutMainWeaponGlGrenades != "") then {
	_unit addMagazines [_loadoutMainWeaponGlGrenades, 6];
	};
};

if (!(_loadoutHandgunWeapon isEqualTo "")) then {
	_unit addWeapon _loadoutHandgunWeapon;
	{
		_unit addHandgunItem _x;
	} foreach _loadoutHandgunWeaponDevices;
	_unit addMagazines [_loadoutHandgunWeaponMags, 2];
};

if (!(_loadoutLauncherWeapon isEqualTo "")) then {
	_unit addWeapon _loadoutLauncherWeapon;
	if (!(_loadoutLauncherWeaponDevices isEqualTo "")) then {
	{
		_unit addSecondaryWeaponItem _x;
	} foreach _loadoutLauncherWeaponDevices;
	};
	if (!(_loadoutLauncherWeaponMags isEqualTo "")) then {
	_unit addMagazines [_loadoutLauncherWeaponMags, 2];
	};
};

if (!(_loadoutBinoculars isEqualTo "")) then {
	_unit addWeapon _loadoutBinoculars;
};
