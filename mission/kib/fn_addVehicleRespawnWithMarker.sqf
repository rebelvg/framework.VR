/*
0 = [this, WEST,"o_recon","ColorRed","racoon",0.6] spawn KIB_fnc_addVehicleRespawnWithMarker;
OR
0 = [this, WEST,"o_recon","ColorRed","racoon",0.6, "optionalMarker"] spawn KIB_fnc_addVehicleRespawnWithMarker;

1: _vehicle - техника, если ставите в инит техники, то прописывайте this
2: WEST - сторона игроков, необходимо для того, чтобы техника респавнилась с вооружением которое подхватывается из лодаута
3: "o_recon" - тип маркера (дефолт "o_unknown")
4: "ColorRed" - цвет маркера (дефолт "ColorGrey")
5: "racoon" - опциональная подпись маркера, если не нужна то оставляйте пустую строку ""
6: 0.6 - прозрачность маркера от 0 до 1 (дефолт 0.5)
7: опциональный параметр. Здесь в кавычках ставите вариаблнейм маркера который уже заранее поставлен в редакторе (например "base_marker_west" для того, шоб админ или скриптом можно было респавнить на ней игроков), все параметры выше будут перезаписаны и маркер не будет удаляться с карты а просто перевешивается на новую технику. (по дефолту маркера меняют цвет на серый и прозрачность когда технику выпиливают, после чего удаляются).

https://community.bistudio.com/wiki/cfgMarkers //marker types
o_motor_inf
o_mech_inf
o_armor
o_recon
o_air
o_plane
o_med
o_hq

https://community.bistudio.com/wiki/Arma_3_CfgMarkerColors //marker colors
ColorRed
ColorBrown
ColorOrange
ColorYellow
ColorKhaki
ColorGreen
ColorBlue
ColorPink
*/

params ["_vehicle", ["_side", sideEmpty],["_markertype","o_unknown"],["_markerColor","ColorGrey"],["_markeText",""],["_markerTransparency",0.5],["_markerPlaced",false]];

if (!isServer) exitWith {};

if (_vehicle isKindOf "Man") exitWith {};

_vehicle setVariable ["mf_vehicleRespawnPos", getPosATL _vehicle];
_vehicle setVariable ["mf_vehicleDir", getDir _vehicle];
_vehicle setVariable ["mf_vehicleLoadoutSide", _side];

_vehicle setVariable ["kib_markertype",_markertype];
_vehicle setVariable ["kib_markerColor",_markerColor];
_vehicle setVariable ["kib_markeText",_markeText];
_vehicle setVariable ["kib_markerTransparency",_markerTransparency];
_vehicle setVariable ["kib_placed",_markerPlaced];

waitUntil {time > 3};

[_vehicle,_markertype,_markerColor,_markeText,_markerTransparency,_markerPlaced] spawn KIB_fnc_markers;

if (typeName _markerPlaced == "STRING") then {
    _obj = _vehicle;

    [_obj, {
    params ["_obj"];

    _action = ["mission_itemAction", "Teleport to base", "", {
        _tpPos = getMarkerPos "base_TP";

        private _className = toLower getText (configFile >> "CfgVehicles" >> typeOf player >> "displayName");

        if (_className == "pilot") exitWith {
            _player setPosATL _tpPos;//[_LX,_LY,_LZ];
        };
    }, {true}] call ace_interact_menu_fnc_createAction;

    [_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject
    }] remoteExec ["BIS_fnc_spawn", 0, _obj];
};

_vehicle addMPEventHandler ["MPKilled", {
    _this spawn {
        params ["_vehicle"];

        if (!isServer) exitWith {};

        private _spawnPos = _vehicle getVariable "mf_vehicleRespawnPos";
        private _vehDir = _vehicle getVariable "mf_vehicleDir";
        private _loadoutSide = _vehicle getVariable "mf_vehicleLoadoutSide";
        private _vehClass = typeOf _vehicle;

        private _markertype = _vehicle getVariable "kib_markertype";
        private _markerColor = _vehicle getVariable "kib_markerColor";
        private _markeText = _vehicle getVariable "kib_markeText";
        private _markerTransparency = _vehicle getVariable "kib_markerTransparency";
        private _markerPlaced = _vehicle getVariable "kib_placed";

        sleep 55;
        //sleep 5;   //debug

        private _wrecks = (allDead select {_x distance _spawnPos < 15});

        if (count _wrecks > 0) then {
            {
                deleteVehicle _x;
            } forEach _wrecks;
        };

        sleep 5;

        _spawnPos params ["_x", "_y"];
        private _newVehicle = _vehClass createVehicle ([0, 0, 0] getPos [random 50, random 360]);
        _newVehicle setDir _vehDir;
        _newVehicle setPosATL [_x, _y, 0];


        [[_newVehicle, _loadoutSide], "mf_fnc_fillBox", true, true] call BIS_fnc_MP;

        [_newVehicle, _loadoutSide,_markertype,_markerColor,_markeText,_markerTransparency,_markerPlaced] spawn KIB_fnc_addVehicleRespawnWithMarker;

        if (typeName _markerPlaced == "STRING") then {
            _obj = _newVehicle;
            [_obj, {
            params ["_obj"];

            _action = ["mission_itemAction", "Teleport to base", "", {
                _tpPos = getMarkerPos "base_TP";

                private _className = toLower getText (configFile >> "CfgVehicles" >> typeOf player >> "displayName");

                if (_className == "pilot" ||_className == "crewman") exitWith {
                    _player setPosATL _tpPos;//[_LX,_LY,_LZ];
                };
            }, {true}] call ace_interact_menu_fnc_createAction;

            [_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject
            }] remoteExec ["BIS_fnc_spawn", 0, _obj];
        };

        format ["Vehicle %1 respawned at %2.", _vehClass, mapGridPosition _spawnPos] remoteExec ["systemChat"];
    };
}];
