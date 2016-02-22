//place all mission related stuff here
//do not overwrite this file when copying framework from mission to mission

//you can use loadoutArray_west, loadoutArray_east, loadoutArray_guer, loadoutArray_civ or just loadoutArray for all sides

/*
classesArray = ["class1", "class2", "class3"];
fashionArray = ["uniform", "vest", "headgear", "backpack", "goggles"];
weaponArray1 = ["rifle", [["mag1", number], ["mag2", number]], ["device1", "device2"]];
weaponArray2 = ["handgun", [["mag", number]], ["device"]];
weaponsArray = [weaponArray1, weaponArray2];
eqpArray = [classesArray, [fashionArray, weaponsArray]];
*/

/*
//example

_classesArray = ["officer", "squad leader", "team leader"];
_fahionArray = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""];
_weaponArray1 = ["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]];
_weaponArray2 = ["hgun_Pistol_heavy_01_MRD_F", [["11Rnd_45ACP_Mag", 3]], ["optic_MRD"]];
_weaponsArray = [_weaponArray1, _weaponArray2];
_eqpArray1 = [_classesArray, [_fashionArray, _weaponsArray]];

_classesArray = ["rifleman"];
_fahionArray = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "", "", ""];
_weaponArray1 = ["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]];
_weaponsArray = [_weaponArray1];
_eqpArray2 = [_classesArray, [_fashionArray, _weaponsArray]];

loadoutArray = [
	[
		_eqpArray1,
		_eqpArray2
	], //equipment
	[
		[
			["ACE_EarPlugs", 1]
		],
		[
			"ItemMap"
		]
	], //personal items
	[
		["DemoCharge_Remote_Mag", 30]
	] //additional content for boxes
];
*/

_advancedMedicine = [["ACE_elasticBandage", 10], ["ACE_quikclot", 10], ["ACE_morphine", 4], ["ACE_epinephrine", 2], ["ACE_atropine", 1], ["ACE_tourniquet", 1]];
_basicMedicine = [["ACE_elasticBandage", 10], ["ACE_morphine", 4], ["ACE_epinephrine", 2]];
_advancedMedic = [["ACE_elasticBandage", 5], ["ACE_quikclot", 5], ["ACE_morphine", 6], ["ACE_epinephrine", 8], ["ACE_atropine", 4], ["ACE_tourniquet", 4], ["ACE_personalAidKit", 3], ["ACE_salineIV_500", 2]];
_basicMedic = [["ACE_elasticBandage", 5], ["ACE_morphine", 6], ["ACE_epinephrine", 6], ["ACE_salineIV_500", 2]];

loadoutArray = [
	[
		[
			["officer", "squad leader", "team leader"],
			[
				["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""],
				[["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]], ["hgun_Pistol_heavy_01_MRD_F", [["11Rnd_45ACP_Mag", 3]], ["optic_MRD"]], ["Laserdesignator", [], []]]
			]
		],
		[
			["rifleman"],
			[
				["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""],
				[["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]]]
			]
		],
		[
			["autorifleman"],
			[
				["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""],
				[["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]]]
			]
		],
		[
			["rifleman (at)"],
			[
				["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""],
				[["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]]]
			]
		],
		[
			["missile specialist (at)"],
			[
				["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""],
				[["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]]]
			]
		],
		[
			["engineer"],
			[
				["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_AssaultPack_cbr", ""],
				[["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 7], ["1Rnd_HE_Grenade_shell", 3]], ["optic_Aco"]]]
			]
		]
	], //equipment
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
			["officer", "squad leader", "team leader"],
			[["EWK_Cigar1", 1], ["murshun_cigs_lighter", 1]]
		],
		[
			["combat life saver"],
			_advancedMedic
		],
		[
			["all units"],
			_advancedMedicine + [["ACE_Clacker", 1]]
		]
	] //additional items per class
];

loadoutArray_west = loadoutArray;
loadoutArray_east = [];
loadoutArray_guer = [];
loadoutArray_civ = [];
