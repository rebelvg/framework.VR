# KLPQ Operations Framework

## Overview
Arma 3 Framework (Template Mission) for KLPQ operations.

## Dependencies

### Requirements
- Latest ARMA 3.
- CBA.
- ACE3.
- DAC.
- KLPQ framework addon.

### Optionals
- ACRE2.

## Settings
https://github.com/rebelvg/framework.VR/wiki/Settings

## AI
https://github.com/rebelvg/framework.VR/wiki/AI-Functions

## Loadouts `mission\loadouts`
https://github.com/rebelvg/framework.VR/tree/master/mission/loadouts

## Framework Functions

### Boxes
Sides - **WEST**, **EAST**, **RESISTANCE**, **CIVILIAN**.
- `0 = [this, WEST] spawn mf_fnc_fillBox;`
- `0 = [this] spawn mf_fnc_fillBoxMedical;`

### Vehicle Respawn
Sides - **WEST**, **EAST**, **RESISTANCE**, **CIVILIAN**.
- `0 = [this, WEST] spawn mf_fnc_addVehicleRespawn;`
- `0 = [this] spawn mf_fnc_addVehicleRespawn;`

### Music Radio
- `0 = [this] call mf_fnc_addMusicRadio;` - adds music radio to an object.

## Spectator Functions

### Spectator Revive
- `[getMarkerPos "base_marker"] spawn murshun_spectator_reviveAllPlayers_fnc;`
- `[] spawn murshun_spectator_reviveAllPlayers_fnc;`

## Examples
- Tasks - `examples\tasks.sqf`
- Boxes - `mission\boxes` folder

## Details

### Variables
- `klpq_framework_version` - string, contains framework semver version number.

### Editor/Singleplayer Settings
- Loadout boxes have virtual arsenal added.
- Loadouts are issued for all playable units.
- All playable units have movement disabled.
- Zeus is enabled.
- Pilots restriction is ignored.
- DAC has debug mode enabled.
