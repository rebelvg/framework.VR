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

Spectator is located inside of our murshun pack. If you want to enable it you must add a few lines.

[] execVM "murshun_menu\spectator\init.sqf";
in init.sqf

[] execVM "murshun_menu\spectator\onPlayerKilled.sqf";
in onPlayerKilled.sqf

[] execVM "murshun_menu\spectator\onPlayerRespawn.sqf";
in onPlayerRespawn.sqf

Framework should not throw ANY script errors. If you see any errors connected to the framework, you're probably doing something wrong, ask rebel.

Framework settings are located in the mission\fn_settings.sqf
List of songs and themes for murshun radio.
https://gist.github.com/rebelvg/a16187f3a7b930fd958b0f0c9db7782f
If music related arrays are empty, script will use all available songs or themes.

You need to set mf_groupChannel for all playable units.
Example.
this setVariable ["mf_groupChannel", [1, 1]];
[1, 1] is a special radio array, 1 is a squad, 1 is a team.
Squads available - 1 to 6, squad 7 is reserved for command network.
Teams available - 1 to 4, team 5 is reserved for squad command network.
So in total you can have 6 squads with 4 fireteams per squad which is more than enough which can cover up to 96 players (not counting any command players).
Colors will be applied automatically.
Modified roster script adds frequencies to the roster.

To enable suicide set murshun_easywayout_canSuicide to true in the init.sqf.
To disable JIP teleportation set murshun_allowJipTeleporting to false in the inti.sqf (JIP teleportation enabled by default in the murshun_menu pbo).

Radios are now automatically added to any vehicle.
To add radio to an object use the line below.
0 = [this] execVM "musicRadio\radioInit.sqf";
Script will automatically detect if the object is a vehicle or a static object and will act accordingly.
To start the radio use ace-interaction menu.

Framework supports per-side loadouts.
Visit mission\loadouts folder.
Also for boxes and cars.
0 = [this, WEST] spawn mf_fnc_fillBox;
0 = [this, EAST] spawn mf_fnc_fillBox;
0 = [this, RESISTANCE] spawn mf_fnc_fillBox;
0 = [this, CIVILIAN] spawn mf_fnc_fillBox;
0 = [this] spawn mf_fnc_fillBoxMedical; //box with advanced medical equipment

If framework can't find the correct side loadoutArray it will skip the loadouts distribution.

You can create custom loadouts for enemies now.
Just set murshun_customEnemyLoadouts to true in the init.sqf and create a loadoutArray for your enemy side.
So for example your enemies are opfor just create loadoutArray_east and fill it accordingly to the standard.

Framework now supports respawn integration in a gameplay form.
All you need is a "base_marker" on the base. As mission maker you can move it after each objective to other places you want.
If you want to have an object that will respawn players near it you need to place
0 = [this] spawn mf_fnc_addReviveBase;
in the object's init.
Only officers and squad leaders will be able to call for respawn.
If you, as mission maker, want to respawn people on the base_marker you can execute
[] spawn murshun_spectator_reviveAllPlayers_fnc;
in your tasks. Execute only once from the server side.

Framework now supports random generation of radio frequencies for each squad.
Can be useful for TVTs.
To enable random frequency generation switch murshun_framework_generateRandomFreqs to true in the init.sqf
Team roster and radio briefing will reflect all that data.

Recommended settings for TVT missions.
description.ext - enableDebugConsole = 0;
Alive Require Module - Disable Admin Actions - Yes.
Alive Player Options - Max View Distance - 1500.
Alive Player Options - Min Terrain Grid - 2.
Ace View Distance Limiter - 1500.

Some examples are located in the examples folder.

ACRE2 and TFAR details.
Framework now supports both radio systems and is backwards compatible.
Just leave tfar and acre radios in the loadouts, they will be added only if the respective mod is enabled.
Missions made for acre will work with tfar if we suddenly decide to switch back.
To fight some of the acre performance issues, framework removes all items from ai units and boxes.
And boxes on the base will have infinite number items.
What I mean by items is stuff like - bandages, earplugs, etc, not mags or weapons or uniforms.
That's happening because acre scans boxes for radios, and if a box has to many items in it, acre will produce freezes cause it's trying to scan to many items in one frame.
It's an engine limitation, can't be easily fixed completely atm, acre team is working on a workaround and optimizing.

New option to allow only pilot to control fly helicopters.
To enabled it switch mf_onlyPilotsCanFly to true in the fn_settings.sqf
The way it works it restricts pilot sit for everyone but pilots, but allows for the use of co-pilot sit while restricting taking controls for non-pilots.
However, it allows to switch sits while flying and allows taking controls while flying, to help during emergency situations.
So basically it just restricts taking off for non-pilots.
