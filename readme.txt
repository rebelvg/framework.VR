https://github.com/rebelvg/framework.VR

Requirements.
Latest ARMA 3.
CBA.
ACE3.
ALIVE.
TFAR.
DAC.
Spectator, Jip teleporting script, Cigs and Suicide script are located in the murshun mods pack. All are completely optional.

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

radioNetArray is located in the framework\init.sqf
You need to set radio_channel for all playable units.
this setVariable ["radio_channel", [1,0]];
[1,0] is a special radio array, 1 is a squad, 0 is a team, squad 7 is reserved for command, team 0 is squad leader and medic
Colors will be applied automatically.
Modified roster script adds frequencies to the roster.

0 = [this] execVM "scripts\boxes\box.sqf"; //add this to the main box, it uses loadoutArray to place things in, works for vehicles too
Main box will have virtual arsenal enabled but only in singleplayer (for loadout tests).
0 = [this] execVM "scripts\boxes\box_medical.sqf"; //box with advanced medical equipment

To enable suicide set murshun_canSuicide to true in the init.sqf.
To disable JIP teleportation set murshun_allowJipTeleporting to false in the inti.sqf (JIP teleportation enabled by default in the murshun_menu pbo).

If you want to have music radio in your mission uncomment musicRadiosArray line and add radio objects inside of the array.
Example.
musicRadiosArray = [musicRadio_01, musicRadio_02, musicRadio_03];
musicRadio_01, etc, have to be an object in the editor (sound will spawn at the object's location, so it's better be a radio type of object, can be anything though).
Add next line to each vehicle that you want to have a radio inside.
0 = [this] execVM "music_radio\vehicleInit.sqf";
or just set murshun_enableRadioInCars to true in the init.sqf for the car to have a radio (works only if you added the box script to the car).

I added a ZES script that allows to place objects in zeus and copy their positions to the clipboard.
Zeus works only in singleplayer so there's no reason to delete the module from the mission when exporting it to the final version.

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

If framework can't find the correct side loadoutArray it will always fallback to the default loadoutArray.
If loadoutArray is empty or do not exist framework will skip the loadouts.

You can create custom loadouts for enemies now.
Just set murshun_customEnemyLoadouts to true in the init.sqf and create a loadoutArray for your enemy side.
So for example your enemies are opfor so just create loadoutArray_east and fill it accordingly to the standard.

By default arma places units from one squad in a wedge formation really far away from each other. So it's kinda hard to predict where some units will actually spawn and that can happen inside a rock or a building.
Framework now moves players closer to the leader right after the mission start. The formation will be saved, but the distance between units will be ~2 meters instead of ~7 by default.
