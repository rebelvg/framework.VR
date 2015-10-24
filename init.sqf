[] execVM "framework\init.sqf"; //framework init
[] execVM "musicRadio\init.sqf"; //music radio init, comment out or remove completely if you don't need a music radio in your mission
[] execVM "murshun_spectator\spectator\init.sqf"; //spectator init

/*
Framework Info.
Framework needs a few lines to be initialized properly.

[] execVM "framework\init.sqf";
in init.sqf

[] execVM "framework\initPlayerLocal.sqf";
in initPlayerLocal.sqf

[] execVM "framework\initServer.sqf";
in initServer.sqf

Framework should not throw ANY script errors. If you see any errors connected to the framework, you're probably doing something wrong, ask rebel.
loadoutArray is located in framework\init.sqf
It's pretty self-explanatory.
Loadouts per class are located in the scripts folder, loadout_west.sqf, loadout_east.sqf, loadout_guer.sqf.
To test your loadouts you can use some neat framework functions.
Execute
[] spawn debugLoadout_fnc;
in the console to test every loadout on your soldier
or 
[] spawn testLoadout_fnc;
to test loadouts on ai units.

Visit initPlayerLocal.sqf and framework\initPlayerLocal.sqf for radios, loadouts, custom roster script, etc.
You need to set up radioNetArray in your initPlayerLocal.
You need to set radio_channel for all playable units.
this setVariable ["radio_channel", [1,0]];
[1,0] is a special radio array, 1 is a squad, 0 is a team, squad 7 is reserved for command, team 0 is squad leader and medic
Colors will be applied automatically.
Modified roster script adds frequencies to the roster.

0 = [this] execVM "scripts\boxes\box.sqf"; //add this to the main box, it uses loadoutArray from framework\init.sqf to place things in
0 = [this] execVM "scripts\boxes\box_medical.sqf"; //box with advanced medical equipment
0 = [this] execVM "scripts\boxes\box_veh.sqf"; //contains same as box.sqf but in smaller quantities
*/

musicRadiosArray = [musicRadio_01]; //musicRadio_01 should be an object in the editor
//remove musicRadiosArray if you don't have and don't need a radio on the base
//add next line to each vehicle that you want to have a radio inside
//0 = [this] execVM "musicRadio\vehicleInit.sqf";
