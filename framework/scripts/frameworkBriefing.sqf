_vars = ["mf_version", "mf_customEnemyLoadouts", "mf_onlyPilotsCanFly", "murshun_spectator_enable", "murshun_easywayout_enable", "murshun_musicRadio_enable", "murshun_radioThemes", "murshun_radioSongs"];

_finalString = "Variable values on mission start.<br/><br/>";

{
	_string = "";
	
	if (!isNil _x) then {
		_string = format ["%1 - %2.<br/>", _x, str (missionNamespace getVariable _x)];
	} else {
		_string = format ["%1 - %2.<br/>", _x, "is not set"];
	};
	
	_finalString = _finalString + _string;
} forEach _vars;

player createDiaryRecord ["diary", ["Framework Settings", _finalString]];
