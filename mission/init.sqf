//place all mission related stuff here
//do not overwrite this file when copying framework from mission to mission

//you can use loadoutArray_west, loadoutArray_east, loadoutArray_guer, loadoutArray_civ

/*
classesArray = ["class1", "class2", "class3"];
fashionArray = ["uniform", "vest", "headgear", "backpack", "goggles"];
weaponArray1 = ["rifle", [["mag1", number], ["mag2", number]], ["device1", "device2"]];
weaponArray2 = ["handgun", [["mag", number]], ["device"]];
weaponsArray = [weaponArray1, weaponArray2];
eqpArray = [classesArray, [fashionArray, weaponsArray]];

randomWeaponArray = selectRandom [weaponArray1, weaponArray2];
*/

_basicMedicine = [["ACE_elasticBandage", 10], ["ACE_morphine", 4], ["ACE_epinephrine", 2]];
_advancedMedicine = [["ACE_elasticBandage", 10], ["ACE_quikclot", 10], ["ACE_morphine", 4], ["ACE_epinephrine", 2], ["ACE_atropine", 1], ["ACE_tourniquet", 1]];

_basicMedic = [["ACE_elasticBandage", 5], ["ACE_morphine", 6], ["ACE_epinephrine", 6], ["ACE_salineIV_500", 2]];
_advancedMedic = [["ACE_elasticBandage", 5], ["ACE_quikclot", 5], ["ACE_morphine", 6], ["ACE_epinephrine", 8], ["ACE_atropine", 4], ["ACE_tourniquet", 4], ["ACE_personalAidKit", 3], ["ACE_salineIV_500", 2]];

_fashionArray = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""];
_fashionPilot = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_Parachute", ""];
_glRifleArray = ["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]];
_rifleArray = ["arifle_MX_F", [["30Rnd_65x39_caseless_mag", 7]], []];
_mgArray = ["arifle_MX_SW_F", [["100Rnd_65x39_caseless_mag_Tracer", 7]], ["bipod_01_F_snd"]];
_handgunArray = ["hgun_P07_F", [["16Rnd_9x21_Mag", 3]], []];
_atLauncher = ["launch_NLAW_F", [], []];
_msLauncher = ["launch_B_Titan_short_F", [["Titan_AT", 3]], []];
_binocularsArray = ["Laserdesignator", [], []];

_loadoutArray_west = [
	[
		[
			["officer", "squad leader", "team leader"],
			[
				_fashionArray,
				[_glRifleArray, _handgunArray, _binocularsArray]
			]
		],
		[
			["rifleman"],
			[
				_fashionArray,
				[_rifleArray]
			]
		],
		[
			["autorifleman"],
			[
				_fashionArray,
				[_mgArray]
			]
		],
		[
			["rifleman (at)"],
			[
				_fashionArray,
				[_rifleArray, _atLauncher]
			]
		],
		[
			["missile specialist (at)"],
			[
				_fashionArray,
				[_rifleArray, _msLauncher]
			]
		],
		[
			["combat life saver"],
			[
				_fashionArray,
				[_rifleArray]
			]
		],
		[
			["engineer"],
			[
				_fashionArray,
				[_rifleArray]
			]
		],
		[
			["pilot"],
			[
				_fashionPilot,
				[_handgunArray]
			]
		]
	], //equipment per class
	[
		[
			["ACE_EarPlugs", 1],
			["ACE_Flashlight_XL50", 1],
			["SmokeShellBlue", 2]
		],
		[
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemGPS",
			"tf_anprc152",
			"NVGoggles"
		]
	], //personal items
	[
		["ToolKit", 2],
		["ACE_wirecutter", 2],
		["ACE_SpareBarrel", 2],
		["DemoCharge_Remote_Mag", 30],
		["SatchelCharge_Remote_Mag", 10],
		["ACE_CableTie", 30],
		["ACE_Clacker", 2],
		["murshun_cigs_matches", 50],
		["EWK_Cig1", 500],
		["HandGrenade", 100]
	], //additional content for boxes
	[
		[
			["officer"],
			[["murshun_cigs_lighter", 1]]
		],
		[
			["combat life saver"],
			_advancedMedic
		],
		[
			["engineer"],
			[["ACE_M26_Clacker", 1]]
		],
		[
			["all units"],
			_advancedMedicine
		]
	] //additional personal items per class
];

loadoutArray_west = _loadoutArray_west;
loadoutArray_east = [];
loadoutArray_guer = [];
loadoutArray_civ = [];
