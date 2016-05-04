[] execVM "framework\init.sqf";
[] execVM "music_radio\init.sqf";
[] execVM "murshun_menu\spectator\init.sqf";
[] execVM "mission\init.sqf";
[] execVM "mission\loadouts.sqf";

//leave empty to use all available themes
murshun_radioThemes = ["slav", "vietnam"];

//leave empty to use all available songs
//if not empty - overrides themes setting
//https://gist.github.com/rebelvg/a16187f3a7b930fd958b0f0c9db7782f
murshun_radioSongs = [];

//do not remove these variables
murshun_easywayout_canSuicide = false;
murshun_allowJipTeleporting = true;
murshun_customEnemyLoadouts = false;
murshun_dance_canDance = false;
murshun_framework_generateRandomFreqs = false;
