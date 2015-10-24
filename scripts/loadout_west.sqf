_unit = _this select 0;
_className = _this select 1;

waituntil {!isNil "loadoutArray"};

removeAllAssignedItems _unit;
removeAllWeapons _unit;
removeBackpack _unit;
removeAllItems _unit;
removeGoggles _unit;
removeUniform _unit;
removeVest _unit;
removeHeadgear _unit;

_uniform = ((loadoutArray select 0) call BIS_fnc_selectRandom);
_vest = ((loadoutArray select 1) call BIS_fnc_selectRandom);
_headgear = ((loadoutArray select 2) call BIS_fnc_selectRandom);
_backpack = ((loadoutArray select 3) call BIS_fnc_selectRandom);
_radioBackpack = (loadoutArray select 4);
_facewear = ((loadoutArray select 5) call BIS_fnc_selectRandom);
_items = (loadoutArray select 6);
_linkItems = (loadoutArray select 7);

if (random 1 >= 0.8) then {
_items = _items + ["murshun_cigs_lighter"];
} else {
_items = _items + ["murshun_cigs_matches"];
};

_rifleArray = ((loadoutArray select 8) call BIS_fnc_selectRandom);
_rifle = _rifleArray select 0;
_rifleMags = _rifleArray select 1;
_rifleDevices = _rifleArray select 2;

_glRifleArray = (loadoutArray select 9);
_glRifle = _glRifleArray select 0;
_glRifleMags = _glRifleArray select 1;
_glGrenade = _glRifleArray select 2;
_glRifleDevices = _glRifleArray select 3;

_allRifleMags = [];

_riflesArray = (loadoutArray select 8);
{
_allRifleMags = _allRifleMags + [_x select 1];
} foreach _riflesArray;

_allRifleMags = _allRifleMags + [_glRifleMags];

_MGArray = (loadoutArray select 10);
_MG = _MGArray select 0;
_MGMags = _MGArray select 1;
_MGDevices = _MGArray select 2;

_marksmanRifleArray = (loadoutArray select 11);
_marksmanRifle = _marksmanRifleArray select 0;
_marksmanMags = _marksmanRifleArray select 1;
_marksmanDevices = _marksmanRifleArray select 2;

_atSingleShot = (loadoutArray select 12);

_atReloadableArray = (loadoutArray select 13);
_atReloadable = _atReloadableArray select 0;
_atMags = _atReloadableArray select 1;
_atDevices = _atReloadableArray select 2;

_aaArray = (loadoutArray select 14);
_aa = _aaArray select 0;
_aaMags = _aaArray select 1;

_grenadesArray = (loadoutArray select 15);
_handGrenade = _grenadesArray select 0;
_smokeGrenade = _grenadesArray select 1;

_handgunArray = (loadoutArray select 16);
_handgun = _handgunArray select 0;
_handgunMags = _handgunArray select 1;
_handgunDevices = _handgunArray select 2;

_binoculars = (loadoutArray select 17);

if (_className == "squad leader" and _radioBackpack != "") then {
_backpack = _radioBackpack;
};

_unit forceAddUniform _uniform;
_unit addVest _vest;
_unit addHeadgear _headgear;
_unit addBackpack _backpack;
_unit addGoggles _facewear;

{
	_unit addItem _x;
} foreach _items;

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemGPS";

{
	_unit linkItem _x;
} foreach _linkItems;

for "_i" from 1 to 10 do {_unit addItem "ACE_elasticBandage";};
for "_i" from 1 to 10 do {_unit addItem "ACE_quikclot";};
for "_i" from 1 to 4 do {_unit addItem "ACE_morphine";};
for "_i" from 1 to 2 do {_unit addItem "ACE_epinephrine";};
for "_i" from 1 to 1 do {_unit addItem "ACE_atropine";};
for "_i" from 1 to 1 do {_unit addItem "ACE_tourniquet";};

for "_i" from 1 to 1 do {_unit addItem _smokeGrenade;};

switch (_className) do {
	case "squad leader": {
	_unit addWeapon _glRifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _glRifleDevices;
	_unit addMagazines [_glRifleMags, 8];
	if (_glGrenade != "") then {
	_unit addMagazines [_glGrenade, 6];
	};
	_unit addWeapon _handgun;
	{
		_unit addHandgunItem _x;
	} foreach _handgunDevices;
	_unit addMagazines [_handgunMags, 2];
	_unit addWeapon _binoculars;
	};
	
	case "team leader": {
	_unit addWeapon _glRifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _glRifleDevices;
	_unit addMagazines [_glRifleMags, 8];
	if (_glGrenade != "") then {
	_unit addMagazines [_glGrenade, 6];
	};
	_unit addWeapon _handgun;
	{
		_unit addHandgunItem _x;
	} foreach _handgunDevices;
	_unit addMagazines [_handgunMags, 2];
	_unit addWeapon _binoculars;
	};
	
	case "combat life saver": {
	_unit addWeapon _rifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _rifleDevices;
	for "_i" from 1 to 15 do {_unit addItem "ACE_elasticBandage";};
	for "_i" from 1 to 15 do {_unit addItem "ACE_quikclot";};
	for "_i" from 1 to 10 do {_unit addItem "ACE_morphine";};
	for "_i" from 1 to 10 do {_unit addItem "ACE_epinephrine";};
	for "_i" from 1 to 10 do {_unit addItem "ACE_atropine";};
	for "_i" from 1 to 5 do {_unit addItem "ACE_tourniquet";};
	for "_i" from 1 to 5 do {_unit addItem "ACE_salineIV_500";};
	for "_i" from 1 to 3 do {_unit addItem "ACE_personalAidKit";};	
	_unit addMagazines [_rifleMags, 8];
	};
	
	case "autorifleman": {
	_unit addWeapon _MG;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _mgDevices;
	_unit addMagazines [_MGMags, 5];
	};
	
	case "rifleman (at)": {
	_unit addWeapon _rifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _rifleDevices;
	_unit addMagazines [_rifleMags, 8];
	_unit addWeapon _atSingleShot;
	};
	
	case "missile specialist (at)": {
	_unit addWeapon _rifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _rifleDevices;
	_unit addMagazines [_rifleMags, 8];
	_unit addWeapon _atReloadable;
	{
		_unit addSecondaryWeaponItem _x;
	} foreach _atDevices;
	_unit addMagazines [_atMags, 5];
	};
	
	case "rifleman": {
	_unit addWeapon _rifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _rifleDevices;
	_unit addMagazines [_rifleMags, 8];
	};
	
	case "engineer": {
	_unit addWeapon _rifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _rifleDevices;
	_unit addMagazines [_rifleMags, 8];
	_unit addItem "ACE_M26_Clacker";
	_unit addItem "ACE_DefusalKit";
	for "_i" from 1 to 3 do {_unit addItem "DemoCharge_Remote_Mag";};
	for "_i" from 1 to 1 do {_unit addItem "SatchelCharge_Remote_Mag";};
	};
	
	case "marksman": {
	_unit addWeapon _marksmanRifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _marksmanDevices;
	_unit addMagazines [_marksmanMags, 8];
	};
	
	case "grenadier": {
	_unit addWeapon _glRifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _glRifleDevices;
	_unit addMagazines [_glRifleMags, 8];
	if (_glGrenade != "") then {
	_unit addMagazines [_glGrenade, 6];
	};
	};
	
	case "missile specialist (aa)": {
	_unit addWeapon _rifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _rifleDevices;
	_unit addMagazines [_rifleMags, 8];
	_unit addWeapon _aa;
	_unit addMagazines [_aaMags, 5];
	};
	
	default {
	 _unit addWeapon _rifle;
	{
		_unit addPrimaryWeaponItem _x;
	} foreach _rifleDevices;
	_unit addMagazines [_rifleMags, 8];
	systemchat "wrong loadout classname, falling back to rifleman";
	};
};
