https://github.com/rebelvg/framework.VR

-------------------------------
INFO.

-- Requirements.
Latest ARMA 3.
CBA.
ACE3.
ALIVE.
DAC.

-- Optionals.
ACRE2.
-------------------------------

-------------------------------
SETTINGS.

-- Variables.
Settings - mission\fn_settings.sqf

mf_customEnemyLoadouts - bool, custom loadouts for non-playable.
mf_onlyPilotsCanFly - bool, forbids taking off by non-pilots.

murshun_spectator_enable - bool, enables murshun spectator.
murshun_easywayout_enable - bool, enables easywayout mod.

murshun_musicRadio_enable - bool, enables murshun music radio.
murshun_radioThemes - array, sets themes for music radio, leave empty for all themes.
murshun_radioSongs - array, sets songs for music radio, leave empty for all songs.
https://gist.github.com/rebelvg/a16187f3a7b930fd958b0f0c9db7782f
-------------------------------

-------------------------------
LOADOUTS.

-- Units.
Loadouts - mission\loadouts folder.

-- Boxes.
Sides - WEST, EAST, RESISTANCE, CIVILIAN.
0 = [this, WEST] spawn mf_fnc_fillBox;
0 = [this] spawn mf_fnc_fillBoxMedical;
-------------------------------

-------------------------------
FRAMEWORK FUNCTIONS.

-- Vehicle respawn.
Sides - WEST, EAST, RESISTANCE, CIVILIAN.
0 = [this, WEST] spawn mf_fnc_addVehicleRespawn;
or
0 = [this] spawn mf_fnc_addVehicleRespawn;

-- Music radio for an object.
0 = [this] call mf_fnc_addMusicRadio;
-------------------------------

-------------------------------
SPECTATOR FUNCTIONS.

-- Spectator revive.
[getMarkerPos "base_marker"] spawn murshun_spectator_reviveAllPlayers_fnc;
or
[] spawn murshun_spectator_reviveAllPlayers_fnc;
-------------------------------

-------------------------------
EXAMPLES.

Tasks - examples\tasks.sqf
Boxes - mission\boxes folder.
-------------------------------

-------------------------------
DETAILS.

-- Variables.
mf_version - number, contains framework version number.

-- Editor/Singleplayer settings.
Loadout boxes have virtual arsenal added.
Loadouts are issued for all playable units.
All playable units have movement disabled.
Zeus is enabled.
Pilots restriction is ignored.
DAC has debug mode enabled.

-- Things framework does automatically.
Manages loadouts on spawn and respawn.
Sets ACRE radio channels.
Applies team colors.
Clears boxes.
Clears vehicle containers.
Adds music radio to vehicles.
ACRE items optimizations.
ACRE client-server inventory desync fixes.
-------------------------------
