/*
https://github.com/rebelvg/framework.VR

Framework Info.
Framework needs a few lines to be initialized properly.

[] execVM "framework\init.sqf";
in init.sqf

[] execVM "framework\initPlayerLocal.sqf";
in initPlayerLocal.sqf

[] execVM "framework\initServer.sqf";
in initServer.sqf

Framework should not throw ANY script errors. If you see any errors connected to the framework, you're probably doing something wrong, ask rebel.
loadoutArray is located in mission\init.sqf
It's pretty self-explanatory.
To test your loadouts you can use some neat framework functions.
Execute
[] spawn debugLoadout_fnc;
to test loadouts on ai units.

You need to set up radioNetArray in your initPlayerLocal.
You need to set radio_channel for all playable units.
this setVariable ["radio_channel", [1,0]];
[1,0] is a special radio array, 1 is a squad, 0 is a team, squad 7 is reserved for command, team 0 is squad leader and medic
Colors will be applied automatically.
Modified roster script adds frequencies to the roster.

0 = [this] execVM "scripts\boxes\box.sqf"; //add this to the main box, it uses loadoutArray to place things in
Main box will have virtual arsenal enabled but only in singleplayer (for loadout tests).
0 = [this] execVM "scripts\boxes\box_medical.sqf"; //box with advanced medical equipment
0 = [this] execVM "scripts\boxes\box_veh.sqf"; //contains same as box.sqf but in smaller quantities

To enable suicide set canSuicide to true in the init.sqf.
To disable JIP teleportation set murshun_allowJipTeleporting to false in the inti.sqf (JIP teleportation enabled by default in the murshun_menu pbo).

If you want to have music radio in your mission uncomment musicRadiosArray line and add radio objects inside of the array.
Example.
musicRadiosArray = [musicRadio_01, musicRadio_02, musicRadio_03];
musicRadio_01, etc, have to be an object in the editor (sound will spawn at the object's location, so it's better be a radio type of object, can be anything though).
Sometimes music tracks can overlap each other (caused by alt-tabing, saving or pressing escape sometimes), arma bug, gonna be fixed in 1.54.
Add next line to each vehicle that you want to have a radio inside.
0 = [this] execVM "music_radio\vehicleInit.sqf";

I added a ZES script that allows to place objects in zeus and copy their positions to the clipboard.
It works only in singleplayer so there's no reason to delete the module from the mission when exporting it to the final version.

Framework now supports per-side loadouts.
loadoutArray_west
loadoutArray_east
loadoutArray_guer
loadoutArray_civ
and for boxes and cars
0 = [this, WEST] execVM "scripts\boxes\box.sqf";
0 = [this, EAST] execVM "scripts\boxes\box.sqf";
0 = [this, RESISTANCE] execVM "scripts\boxes\box.sqf";
0 = [this, CIVILIAN] execVM "scripts\boxes\box.sqf";

If framework can't find the correct side loadoutArray it will always fallback to the loadoutArray.
If loadoutArray is empty framework will skip the loadouts.
*/
