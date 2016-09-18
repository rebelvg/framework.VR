https://github.com/rebelvg/framework.VR

Requirements.
Latest ARMA 3.
CBA.
ACE3.
ALIVE.
DAC.

Optionals.
ACRE2.

Framework Info.
Spectator is located inside of our murshun pack. You can switch it by changing the value murshun_spectator_enable in the mission\fn_settings.sqf

Framework should not throw ANY script errors. If you see any errors connected to the framework, you're probably doing something wrong, ask rebel.

Framework settings are located in the mission\fn_settings.sqf

You need to set mf_groupChannel for all playable units.
Used for automatic radio configuration.
Example.
this setVariable ["mf_groupChannel", [1, 1]];
[1, 1] is a special radio array, 1 is a squad, 1 is a team.
Squads available - 1 to 6, squad 7 is reserved for command network.
Teams available - 1 to 4, team 5 is reserved for squad command network.
So in total you can have 6 squads with 4 fireteams per squad which is more than enough which can cover up to 96 players (not counting any command players).
Colors will be applied automatically.

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
If you want to have an object that will respawn players near it you need to place
0 = [this] spawn mf_fnc_addReviveBase;
in the object's init.
Add
0 = [this] spawn mf_fnc_addTeleportBase;
to the box if you want this box to have a teleport to your squad option.

If you, as mission maker, want to respawn people on the base_marker you can execute
[] spawn murshun_spectator_reviveAllPlayers_fnc;
in your tasks. Execute only once from the server side.
If base_marker is not present, they will respawn on the position they first spawned in.
Or respawn people at a specific location using example below.
[getMarkerPos "base_marker"] spawn murshun_spectator_reviveAllPlayers_fnc;
Or use any other command that returns coordinates.

Recommended settings for TVT missions.
description.ext - enableDebugConsole = 0;
Alive Require Module - Disable Admin Actions - Yes.
Alive Player Options - Max View Distance - 1500.
Alive Player Options - Min Terrain Grid - 2.
Ace View Distance Limiter - 1500.

New option to allow only pilots to fly helicopters.
To enable it switch mf_onlyPilotsCanFly to true in the mission\fn_settings.sqf
The way it works it restricts pilot sit for everyone but pilots, but allows for the use of co-pilot sit while restricting taking controls for non-pilots.
However, it allows to switch sits while flying and allows taking controls while flying, to help during emergency situations.
So basically it just restricts taking off for non-pilots.
Activates only in multiplayer.

Radios are now automatically added to any vehicle.
To add radio to an object use the line below.
0 = [this] execVM "musicRadio\radioInit.sqf";
Script will automatically detect if the object is a vehicle or a static object and will act accordingly.
To start the radio use ace-interaction menu.

List of songs and themes for murshun radio.
https://gist.github.com/rebelvg/a16187f3a7b930fd958b0f0c9db7782f
If music related arrays are empty, script will use all available songs or themes.
