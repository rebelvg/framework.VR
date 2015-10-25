[] execVM "framework\init.sqf";
[] execVM "musicRadio\init.sqf";
[] execVM "murshun_spectator\spectator\init.sqf";

if (!isNil "musicRadio_01") then {
musicRadiosArray = [musicRadio_01];
};
