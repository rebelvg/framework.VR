https://github.com/rebelvg/framework.VR

Requirements.
Latest ARMA 3.
CBA.
ACE3.
ALIVE.
TFAR.
DAC.
Spectator, Jip teleporting script, Cigs and Suicide script are located in the murshun mod pack. All are completely optional.

Framework Info.
Framework needs a few lines to be initialized properly.

[] execVM "framework\init.sqf";
in init.sqf

[] execVM "framework\initPlayerLocal.sqf";
in initPlayerLocal.sqf

[] execVM "framework\initServer.sqf";
in initServer.sqf

Spectator is located inside of our murshun pack. If you want to enable it you must add a few lines.

[] execVM "murshun_menu\spectator\init.sqf";
in init.sqf

[player] execVM "murshun_menu\spectator\onPlayerKilled.sqf";
in onPlayerKilled.sqf

[player] execVM "murshun_menu\spectator\onPlayerRespawn.sqf";
in onPlayerRespawn.sqf

Framework should not throw ANY script errors. If you see any errors connected to the framework, you're probably doing something wrong, ask rebel.
loadoutArray is located in mission\init.sqf
It's pretty self-explanatory.

You need to set radio_channel for all playable units.
this setVariable ["radio_channel", [1, 1]];
[1, 1] is a special radio array, 1 is a squad, 1 is a team.
Squads available - 1 to 6, squad 7 is reserved for command network.
Teams available - 1 to 4, team 5 is reserved for squad command network.
So in total you can have 6 squads with 4 fireteams per squad which is more then enough which can cover up to 96 players (not counting any command players).
Colors will be applied automatically.
Modified roster script adds frequencies to the roster.

0 = [this] execVM "scripts\boxes\box.sqf"; //add this to the main box, it uses loadoutArray to place things in, works for vehicles too
Main box will have virtual arsenal enabled but only in singleplayer (for loadout selection).
0 = [this] execVM "scripts\boxes\box_medical.sqf"; //box with advanced medical equipment

To enable suicide set murshun_easywayout_canSuicide to true in the init.sqf.
To disable JIP teleportation set murshun_allowJipTeleporting to false in the inti.sqf (JIP teleportation enabled by default in the murshun_menu pbo).

If you want to have music radio in your mission all you need to do is to add only one line to the object.
Add next line to each vehicle or object that you want to have a radio inside or be a radio.
Script will automatically detect if the object is a vehicle or a static object and will act accordingly.
0 = [this] execVM "music_radio\radioInit.sqf";
To start the radio use ace-interaction menu.

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

If framework can't find the correct side loadoutArray it will skip the loadouts distribution.

You can create custom loadouts for enemies now.
Just set murshun_customEnemyLoadouts to true in the init.sqf and create a loadoutArray for your enemy side.
So for example your enemies are opfor just create loadoutArray_east and fill it accordingly to the standard.

Framework now supports respawn integration in a gameplay form.
All you need is a "base_marker" on the base. As mission maker you can move it after each objective to other places you want.
If you want to have an object that will respawn players on the base_marker you need to place
0 = [this] execVM "scripts\revive_players.sqf";
in the object's init.
Only officers and squad leaders will be able to call for respawn.
If you, as mission maker, want to respawn people on the base_marker you can execute
[] spawn murshun_framework_revivePlayers_fnc;
in your tasks. Execute only once from the server side.

Framework now supports random generation of radio frequencies for each squad.
Can be useful for TVTs.
To enable random frequency generation switch murshun_framework_generateRandomFreqs to true in the init.sqf
Team roster and radio briefing will reflect all that data.
