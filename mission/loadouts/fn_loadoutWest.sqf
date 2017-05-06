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

_basicMedicine = [["ACE_fieldDressing", 20], ["ACE_morphine", 10], ["ACE_epinephrine", 2], ["ACE_bloodIV_250", 1]];
_advancedMedicine = [["ACE_fieldDressing", 10], ["ACE_quikclot", 10], ["ACE_morphine", 10], ["ACE_epinephrine", 2], ["ACE_tourniquet", 1], ["ACE_personalAidKit", 1], ["ACE_bloodIV_250", 1]];

_medicine = _basicMedicine;

_basicMedicMedicine = [["ACE_fieldDressing", 40], ["ACE_morphine", 20], ["ACE_epinephrine", 4], ["ACE_bloodIV_250", 2]];
_advancedMedicMedicine = [["ACE_fieldDressing", 20], ["ACE_quikclot", 20], ["ACE_morphine", 20], ["ACE_epinephrine", 4], ["ACE_tourniquet", 2], ["ACE_personalAidKit", 2], ["ACE_bloodIV_250", 2]];

_medicMedicine = _basicMedicMedicine;

_uniform = "U_B_CombatUniform_mcam";
_vest = "V_BandollierB_rgr";
_riflemanFashion = [_uniform, _vest, "H_HelmetB_sand", "B_Kitbag_cbr", ""];
_specFashion = [_uniform, _vest, "H_HelmetB_sand", "B_Carryall_mcamo", ""];
_leaderFashion = [_uniform, _vest, "H_MilCap_mcamo", "B_Kitbag_cbr", ""];
_crewFashion = [_uniform, _vest, "H_HelmetCrew_B", "B_Kitbag_cbr", ""];
_pilotFashion = [_uniform, _vest, "H_PilotHelmetHeli_B", "B_Kitbag_cbr", ""];

_riflemanPrimary = ["arifle_MX_F", [["30Rnd_65x39_caseless_mag", 15]], []];
_specPrimary = ["arifle_MXC_F", [["30Rnd_65x39_caseless_mag", 15]], []];
_glRifleWeapon = ["arifle_MX_GL_F", [["30Rnd_65x39_caseless_mag", 15], ["1Rnd_HE_Grenade_shell", 15]], ["optic_Aco"]];
_leaderPrimary = _glRifleWeapon;

_mgMag = "100Rnd_65x39_caseless_mag_Tracer";
_mgWeapon = ["arifle_MX_SW_F", [[_mgMag, 15]], ["bipod_01_F_snd"]];
_mgMags = ["", [[_mgMag, 7]], []];

_handgunWeapon = ["hgun_P07_F", [["16Rnd_9x21_Mag", 1]], []];
_leaderSecond = _handgunWeapon;

_atLauncher = "launch_NLAW_F";

_atLauncherWeapon = [_atLauncher, [], []];
_atMissileWeapon = ["launch_B_Titan_short_F", [["Titan_AT", 2]], []];
_aaMissileWeapon = ["launch_B_Titan_F", [["Titan_AA", 2]], []];

_binoculars = ["ACE_VectorDay", [], []];

_additionGrenade = "SmokeShellBlue";
_fragGrenade = "HandGrenade";

_items = [["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], [_additionGrenade, 3], ["ACE_CableTie", 2]];
_linkItems = ["ItemMap", "ItemCompass", "ItemWatch", "ItemGPS", "NVGoggles"];

_boxItems = [
    ["ToolKit", 10],
    ["ACE_wirecutter", 2],
    ["ACE_SpareBarrel", 10],
    ["ACE_CableTie", 80],
    ["ACE_Clacker", 10],
    ["murshun_cigs_cigpack", 40],
    ["murshun_cigs_matches", 40],
    [_atLauncher, 20],
    [_additionGrenade, 200],
    [_fragGrenade, 80],
    ["DemoCharge_Remote_Mag", 20],
    ["SatchelCharge_Remote_Mag", 4]
]; //content for boxes

_boxMedicine = _medicine apply {[_x select 0, (_x select 1) * 60]};

_identity = [
    "", //face
    "" //voice
]; //identity, ai only

_loadoutArray = [
    [
        [
            ["officer", "squad leader"],
            [
                _leaderFashion,
                [_leaderPrimary, _leaderSecond, _binoculars]
            ]
        ],
        [
            ["combat life saver"],
            [
                _specFashion,
                [_specPrimary]
            ]
        ],
        [
            ["engineer"],
            [
                _specFashion,
                [_specPrimary]
            ]
        ],
        [
            ["team leader"],
            [
                _riflemanFashion,
                [_leaderPrimary, _leaderSecond, _binoculars]
            ]
        ],
        [
            ["missile specialist (at)"],
            [
                _specFashion,
                [_specPrimary, _atMissileWeapon]
            ]
        ],
        [
            ["missile specialist (aa)"],
            [
                _specFashion,
                [_specPrimary, _aaMissileWeapon]
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
                [_riflemanPrimary, _mgMags, _atLauncherWeapon]
            ]
        ],
        [
            ["pilot", "helicopter pilot"],
            [
                _pilotFashion,
                [_specPrimary]
            ]
        ],
        [
            ["crewman", "helicopter crew"],
            [
                _crewFashion,
                [_specPrimary]
            ]
        ],
        [
            ["grenadier"],
            [
                _riflemanFashion,
                [_glRifleWeapon]
            ]
        ],
        [
            ["rifleman"],
            [
                _riflemanFashion,
                [_riflemanPrimary]
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
            ["missile specialist (at)"],
            [],
            []
        ],
        [
            ["missile specialist (aa)"],
            [],
            []
        ],
        [
            ["autorifleman"],
            [],
            []
        ],
        [
            ["rifleman (at)"],
            [],
            []
        ],
        [
            ["pilot", "helicopter pilot", "crewman", "helicopter crew"],
            [["ToolKit", 1]],
            []
        ],
        [
            ["grenadier"],
            [],
            []
        ],
        [
            ["rifleman"],
            [],
            []
        ]
    ], //personal items per class
    _boxItems + _boxMedicine,
    _identity
];

//output of the function, do not remove or change
_loadoutArray
