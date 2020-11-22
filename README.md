# KLPQ Operations Framework

## Overview

Arma 3 Framework (Template Mission) for KLPQ operations.

## Dependencies

### Requirements

- Latest ARMA 3.
- CBA.
- ACE3.
- KLPQ framework addon.

### Optionals

- ACRE2.

## Wiki

https://github.com/rebelvg/framework.VR/wiki

###

Reset units position in editor.

```sqf
private _allSideUnits = allUnits select {side _x == WEST};

private _groupLeaders = _allSideUnits select {_x == leader _x};

[0, 0, 0] params ["_xPos", "_yPos", "_zPos"];

{
  private _groupLeader = _x;
  private _firstIndex = _forEachIndex;

  {
    private _groupUnit = _x;
    private _secondIndex = _forEachIndex;

    _groupUnit setPos [_xPos + _firstIndex, _yPos - _secondIndex, _zPos];
  } forEach (units group _groupLeader);
} forEach _groupLeaders;

private _allObjects = allMissionObjects "All" select {side _x == civilian};

{
  private _object = _x;
  private _firstIndex = _forEachIndex;

  (getPos _object) params ["_xPos", "_yPos", "_zPos"];

  _object setPos [_xPos, 10, _zPos];
} forEach _allObjects;
```
