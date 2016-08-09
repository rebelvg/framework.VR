if (!(isClass (configFile >> "CfgPatches" >> "acre_main"))) exitWith {};

player createDiarySubject ["radioFrequencies", "Radio Frequencies"];

player createDiaryRecord ["radioFrequencies", ["Short Range Frequencies", format ["<br/>
<font color='#FFEC00'><font size='20'>COMMAND NET</font></font color> <br/>
Commander, Squad Leaders, Special  <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC148 / PRC152, Channel - 1</font color><font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>COMMAND</font><br/>
Commander + Medic             	           	  <font color='#FFEC00'>[</font color>Channel 7, Block 5<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>ALPHA</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Channel 1, Block 5</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 1, Block 5<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1, Block 1<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 1, Block 2<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>BRAVO</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Channel 2, Block 5</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 2, Block 5<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 2, Block 1<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2, Block 2<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>CHARLIE</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Channel 3, Block 5</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 3, Block 5<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 3, Block 1<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 3, Block 2<font color='#FFEC00'>]</font color><br/><br/><br/>

Radios are automatically set up for ease of use.<br/>
<font color='#FFEC00'>[</font color>CAPS<font color='#FFEC00'>]</font color> is bound for inter-group communication.<br/>
<font color='#FFEC00'>[</font color><font color='#8A8A8A'>T</font color><font color='#FFEC00'>]</font color> is bound for for higher-up communication.<br/>
Fireteam members do not have an alternative channel.<br/><br/>

<t underline='true'>IMPORTANT</t> - Remember the radio channels for your squad<br/>
so you can re-establish communications if leaders are KIA or missing."]]];

waitUntil {
	time > 0 and [] call acre_api_fnc_isInitialized
};

_mf_groupChannel = player getVariable ["mf_groupChannel", [6, 4]];
_channel = _mf_groupChannel select 0;
_team = _mf_groupChannel select 1;

_343Radios = (items player) select {[_x] call acre_api_fnc_getBaseRadio == "ACRE_PRC343"};
_148Radios = (items player) select {[_x] call acre_api_fnc_getBaseRadio == "ACRE_PRC148"};
_152Radios = (items player) select {[_x] call acre_api_fnc_getBaseRadio == "ACRE_PRC152"};

if (count _343Radios > 0) then {
	[(_343Radios select 0), _channel + (_team - 1) * 16] call acre_api_fnc_setRadioChannel;
	[(_343Radios select 0), "LEFT"] call acre_api_fnc_setRadioSpatial;
	[(_343Radios select 0)] call acre_api_fnc_setCurrentRadio;
};

if (count _148Radios > 0) then {
	[(_148Radios select 0), "RIGHT"] call acre_api_fnc_setRadioSpatial;
};

if (count _152Radios > 0) then {
	[(_152Radios select 0), "RIGHT"] call acre_api_fnc_setRadioSpatial;
};

_className = tolower gettext (configFile >> "CfgVehicles" >> typeOf player >> "displayName");

if (_className == "team leader") then {
	if (count _343Radios > 1) then {
		[(_343Radios select 1), _channel + 64] call acre_api_fnc_setRadioChannel;
		[(_343Radios select 1), "RIGHT"] call acre_api_fnc_setRadioSpatial;
	};
};
