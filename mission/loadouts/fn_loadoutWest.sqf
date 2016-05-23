//place all mission related stuff here
//do not overwrite this file when copying framework from mission to mission

/*
classesArray = ["class1", "class2", "class3"];
fashionArray = ["uniform", "vest", "headgear", "backpack", "goggles"];
weaponArray1 = ["rifle1", [["mag1", number], ["mag2", number]], ["device1", "device2"]];
weaponArray2 = ["rifle2", [["mag1", number], ["mag2", number]], ["device1", "device2"]];
handgunArray1 = ["handgun", [["mag", number]], ["device"]];
weaponsArray = [weaponArray1, handgunArray1];
eqpArray = [classesArray, [fashionArray, weaponsArray]];
*/

_basicMedicine = [["ACE_elasticBandage", 5], ["ACE_morphine", 2], ["ACE_epinephrine", 2]];
_advancedMedicine = [["ACE_elasticBandage", 5], ["ACE_quikclot", 5], ["ACE_morphine", 2], ["ACE_epinephrine", 2], ["ACE_atropine", 2], ["ACE_tourniquet", 1]];
_basicMedicMedicine = [["ACE_elasticBandage", 10], ["ACE_morphine", 3], ["ACE_epinephrine", 3], ["ACE_salineIV_500", 2]];
_advancedMedicMedicine = [["ACE_elasticBandage", 10], ["ACE_quikclot", 10], ["ACE_morphine", 3], ["ACE_epinephrine", 3], ["ACE_atropine", 3], ["ACE_tourniquet", 2], ["ACE_personalAidKit", 2], ["ACE_salineIV_500", 2]];

_leaderFashionArray = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""];
_fashionArray = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""];
_pilotFashionArray = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_Parachute", ""];

_slRifleArray = ["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]];
_rifleArray = ["arifle_MX_F", [["30Rnd_65x39_caseless_mag", 7]], []];
_mgArray = ["arifle_MX_SW_F", [["100Rnd_65x39_caseless_mag_Tracer", 7]], ["bipod_01_F_snd"]];
_handgunArray = ["hgun_P07_F", [["16Rnd_9x21_Mag", 3]], []];
_atLauncherArray = ["launch_NLAW_F", [], []];
_msLauncherArray = ["launch_B_Titan_short_F", [["Titan_AT", 3]], []];
_binocularsArray = ["Laserdesignator", [], []];

_loadoutArray = [
	[
		[
			["officer", "squad leader"],
			[
				_leaderFashionArray,
				[_slRifleArray, _handgunArray, _binocularsArray]
			]
		],
		[
			["team leader"],
			[
				_fashionArray,
				[_slRifleArray, _handgunArray, _binocularsArray]
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
				[_rifleArray, _atLauncherArray]
			]
		],
		[
			["missile specialist (at)"],
			[
				_fashionArray,
				[_rifleArray, _msLauncherArray]
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
				_pilotFashionArray,
				[_handgunArray]
			]
		]
	], //equipment per class
	[
		[
			["all"],
			[["ACRE_PRC343", 1], ["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], ["SmokeShellBlue", 2], ["ACE_CableTie", 2]] + _advancedMedicine, //items, acre radios go here
			["ItemMap", "ItemCompass", "ItemWatch", "ItemGPS", "tf_anprc152", "NVGoggles"] //link items, tfar radios go here
		],
		[
			["officer", "squad leader"],
			[["ACRE_PRC148", 1], ["murshun_cigs_lighter", 1]],
			[]
		],
		[
			["team leader"],
			[["ACRE_PRC343", 1], ["murshun_cigs_lighter", 1]],
			[]
		],
		[
			["combat life saver"],
			_advancedMedicMedicine,
			[]
		],
		[
			["engineer"],
			[["ACE_M26_Clacker", 1], ["ACE_DefusalKit", 1]],
			[]
		],
		[
			["pilot"],
			[["ACRE_PRC148", 1]],
			[]
		]
	], //personal items per class
	[
		["ACE_EarPlugs", 20],
		["ACE_Flashlight_XL50", 20],
		["ToolKit", 2],
		["ACE_wirecutter", 2],
		["ACE_SpareBarrel", 4],
		["DemoCharge_Remote_Mag", 20],
		["SatchelCharge_Remote_Mag", 4],
		["ACE_CableTie", 10],
		["ACE_Clacker", 2],
		["EWK_Cig1", 100],
		["murshun_cigs_matches", 40],	
		["SmokeShellBlue", 100],
		["HandGrenade", 20]
	] //content for boxes
];

//output of the function, do not remove or change
_loadoutArray
