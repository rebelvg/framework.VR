//place all mission related stuff here
//do not overwrite this file when copying framework from mission to mission

loadoutArray = [
["U_B_CombatUniform_mcam"], //uniforms array 0, supports randomize
["V_PlateCarrier1_rgr"], //vests array 1, supports randomize
["H_HelmetB_desert"], //headgears array 2, supports randomize
["B_FieldPack_khk"], //backpacks array 3, supports randomize
"", // radio backpack 4
["G_Bandanna_khk", ""], //facewears array 5, supports randomize
["ACE_EarPlugs", "ACE_Flashlight_XL50"], //items 6
["ItemMap", "ItemCompass", "ItemWatch", "ItemGPS", "tf_anprc152", "NVGoggles"], //link items 7, personal radio, nvgs
[["arifle_MX_Black_F", "30Rnd_65x39_caseless_mag", ["", "", "", ""]]], //rifles array 8, mag, devices, supports randomize
["arifle_MX_GL_Black_F", "30Rnd_65x39_caseless_mag", "1Rnd_HE_Grenade_shell", ["", "", "", ""]], //gl rifle 9, mag, gl grenade, devices
["arifle_MX_Black_F", "30Rnd_65x39_caseless_mag", ["", "", "", ""]], //mg 10, mag, devices
["arifle_MX_Black_F", "30Rnd_65x39_caseless_mag", ["", "", "", ""]], //marksman rifle 11, mag, devices
"", //at singleshot 12
["", "", ["", "", "", ""]], //at reloadable 13, mag, devices
["", ""], //aa 14, mag
[["HandGrenade"], ["SmokeShellBlue"]], //grenades array 15, lethal grenades, non lethal grenades
["hgun_ACPC2_F", "9Rnd_45ACP_Mag", ["", "", "", ""]], //sl handgun 16, mag, devices
"Laserdesignator", //binoculars 17
[["DemoCharge_Remote_Mag", 30], ["SatchelCharge_Remote_Mag", 10], ["ACE_CableTie", 30], ["ACE_Clacker", 2], ["EWK_Cig1", 100]] //additional content for boxes 18, ["item", quantity], cars will have the same but 3 times less
];
