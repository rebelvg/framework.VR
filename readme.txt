https://github.com/rebelvg/framework.VR

-------------------------------
INFO.

-- Requirements.
Latest ARMA 3.
CBA.
ACE3.
DAC.
KLPQ framework addon.

-- Optionals.
ACRE2.
-------------------------------

-------------------------------
SETTINGS.

-- Variables.
Settings - mission\fn_settings.sqf

KLPQ Framework.
klpq_framework_enable - bool, enables framework.
mf_customEnemyLoadouts - bool, custom loadouts for non-playable units.
mf_onlyPilotsCanFly - bool, forbids taking off by non-pilots.
mf_forceSideNVGs - array, forces NVGs for selected sides (WEST, EAST, RESISTANCE, CIVILIAN), non-playable units only.
mf_forceVirtualArsenal - bool, makes virtual arsenal available on the ammo box in multiplayer.
mf_addParadropOption - bool, adds paradrop to friendlies option to the ammo box.

KLPQ Menu.
murshun_spectator_enable - bool, enables spectator.

Mods.
https://github.com/rebelvg/murshun_easywayout/blob/master/readme.txt
https://github.com/rebelvg/klpq_musicRadio/blob/master/readme.txt

-- AI spawn.
Settings - mission\ai\fn_units.sqf
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
klpq_framework_version - string, contains framework semver version number.

-- Editor/Singleplayer settings.
Loadout boxes have virtual arsenal added.
Loadouts are issued for all playable units.
All playable units have movement disabled.
Zeus is enabled.
Pilots restriction is ignored.
DAC has debug mode enabled.
-------------------------------
