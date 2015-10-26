[] execVM "framework\init.sqf";
[] execVM "music_radio\init.sqf";
[] execVM "murshun_spectator\spectator\init.sqf";

if (!isNil "musicRadio_01") then {
//musicRadiosArray = [musicRadio_01];
};

canSuicide = false;
murshun_allowJipTeleporting = true;
