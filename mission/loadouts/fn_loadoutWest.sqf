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

_basicMedicine = [["ACE_elasticBandage", 20], ["ACE_morphine", 10], ["ACE_epinephrine", 2]];
_advancedMedicine = [["ACE_elasticBandage", 10], ["ACE_quikclot", 10], ["ACE_morphine", 10], ["ACE_epinephrine", 2], ["ACE_tourniquet", 1], ["ACE_personalAidKit", 1]];

_medicine = _basicMedicine;

_basicMedicMedicine = [["ACE_elasticBandage", 40], ["ACE_morphine", 20], ["ACE_epinephrine", 4], ["ACE_bloodIV_250", 2]];
_advancedMedicMedicine = [["ACE_elasticBandage", 20], ["ACE_quikclot", 20], ["ACE_morphine", 20], ["ACE_epinephrine", 4], ["ACE_tourniquet", 2], ["ACE_personalAidKit", 2], ["ACE_bloodIV_250", 2]];

_medicMedicine = _basicMedicMedicine;

_leaderFashion = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_MilCap_mcamo", "B_Kitbag_cbr", ""];
_riflemanFashion = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_HelmetB_sand", "B_Kitbag_cbr", ""];
_crewFashion = ["U_B_CombatUniform_mcam", "V_BandollierB_rgr", "H_HelmetCrew_B", "B_Kitbag_cbr", ""];

_leaderWeapon = ["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 15], ["1Rnd_HE_Grenade_shell", 7]], ["optic_Aco"]];
_riflemanWeapon = ["arifle_MX_F", [["30Rnd_65x39_caseless_mag", 15]], []];
_mgWeapon = ["arifle_MX_SW_F", [["100Rnd_65x39_caseless_mag_Tracer", 7]], ["bipod_01_F_snd"]];

_leaderHandgun = ["hgun_P07_F", [["16Rnd_9x21_Mag", 1]], []];

_riflemanAT = ["launch_NLAW_F", [], []];
_specialistAT = ["launch_B_Titan_short_F", [["Titan_AT", 2]], []];
_specialistAA = ["launch_B_Titan_F", [["Titan_AA", 2]], []];

_binoculars = ["Laserdesignator", [], []];

_boxAT = "launch_NLAW_F";

_nonLethalGrenade = "SmokeShellBlue";
_lethalGrenade = "HandGrenade";

_items = [["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], [_nonLethalGrenade, 3], [_lethalGrenade, 1], ["ACE_CableTie", 1]];
_linkItems = ["ItemMap", "ItemCompass", "ItemWatch", "ItemGPS", "NVGoggles"];

_loadoutArray = [
    [
        [
            ["officer", "squad leader"],
            [
                _leaderFashion,
                [_leaderWeapon, _leaderHandgun, _binoculars]
            ]
        ],
        [
            ["team leader"],
            [
                _leaderFashion,
                [_leaderWeapon, _leaderHandgun, _binoculars]
            ]
        ],
        [
            ["rifleman"],
            [
                _riflemanFashion,
                [_riflemanWeapon]
            ]
        ],
        [
            ["autorifleman"],
            [
                _riflemanFashion,
                [_mgWeapon]
            ]
        ],
        [
            ["rifleman (at)"],
            [
                _riflemanFashion,
                [_riflemanWeapon, _riflemanAT]
            ]
        ],
        [
            ["missile specialist (at)"],
            [
                _riflemanFashion,
                [_riflemanWeapon, _specialistAT]
            ]
        ],
        [
            ["combat life saver"],
            [
                _riflemanFashion,
                [_riflemanWeapon]
            ]
        ],
        [
            ["engineer"],
            [
                _riflemanFashion,
                [_riflemanWeapon]
            ]
        ],
        [
            ["pilot", "crewman"],
            [
                _crewFashion,
                [_riflemanWeapon]
            ]
        ],
        [
            ["missile specialist (aa)"],
            [
                _riflemanFashion,
                [_riflemanWeapon, _specialistAA]
            ]
        ]
    ], //equipment per class
    [
        [
            ["all"],
            [["ACRE_PRC343", 1]],
            []
        ],
        [
            ["officer", "squad leader", "pilot", "crewman"],
            [["ACRE_PRC152", 1]],
            []
        ],
        [
            ["all"],
            _items + _medicine, //items
            _linkItems //link items
        ],
        [
            ["officer", "squad leader", "team leader"],
            [["murshun_cigs_lighter", 1]],
            []
        ],
        [
            ["combat life saver"],
            _medicMedicine,
            []
        ],
        [
            ["engineer"],
            [["ACE_M26_Clacker", 1], ["ACE_DefusalKit", 1], ["DemoCharge_Remote_Mag", 2]],
            []
        ],
        [
            ["pilot", "crewman"],
            [["ToolKit", 1]],
            []
        ]
    ], //personal items per class
    [
        ["ToolKit", 2],
        ["ACE_wirecutter", 2],
        ["ACE_SpareBarrel", 4],
        ["ACE_CableTie", 10],
        ["ACE_Clacker", 2],
        ["murshun_cigs_cigpack", 20],
        ["murshun_cigs_matches", 20],
        [_boxAT, 20],
        [_nonLethalGrenade, 200],
        [_lethalGrenade, 80],
        ["DemoCharge_Remote_Mag", 20],
        ["SatchelCharge_Remote_Mag", 4]
    ] + _medicine //content for boxes
];

//output of the function, do not remove or change
_loadoutArray
