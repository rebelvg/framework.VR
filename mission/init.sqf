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
*/

_advancedMedicine = [["ACE_elasticBandage", 10], ["ACE_quikclot", 10], ["ACE_morphine", 4], ["ACE_epinephrine", 2], ["ACE_atropine", 1], ["ACE_tourniquet", 1]];
_basicMedicine = [["ACE_elasticBandage", 10], ["ACE_morphine", 4], ["ACE_epinephrine", 2]];
_advancedMedic = [["ACE_elasticBandage", 5], ["ACE_quikclot", 5], ["ACE_morphine", 6], ["ACE_epinephrine", 8], ["ACE_atropine", 4], ["ACE_tourniquet", 4], ["ACE_personalAidKit", 3], ["ACE_salineIV_500", 2]];
_basicMedic = [["ACE_elasticBandage", 5], ["ACE_morphine", 6], ["ACE_epinephrine", 6], ["ACE_salineIV_500", 2]];

_fashionArray = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""];
_rifleArray = ["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]];
_handgunArray = ["hgun_P07_F", [["16Rnd_9x21_Mag", 3]], []];
_binocularsArray = ["Laserdesignator", [], []];

loadoutArray = [
	[
		[
			["officer", "squad leader", "team leader"],
			[
				_fashionArray,
				[_rifleArray, _handgunArray, _binocularsArray]
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
				[_rifleArray]
			]
		],
		[
			["rifleman (at)"],
			[
				_fashionArray,
				[_rifleArray]
			]
		],
		[
			["missile specialist (at)"],
			[
				_fashionArray,
				[_rifleArray]
			]
		]
	], //equipment per class
	[
		[
			["ACE_EarPlugs", 1],
			["ACE_Flashlight_XL50", 1],
			["HandGrenade", 1],
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
		["EWK_Cig1", 500]
	], //additional content for boxes
	[
		[
			["combat life saver"],
			_advancedMedic
		],
		[
			["all units"],
			_advancedMedicine
		]
	] //additional personal items per class
];

loadoutArray_west = loadoutArray;
loadoutArray_east = [];
loadoutArray_guer = [];
loadoutArray_civ = [];
