waitUntil {!isNil "radioNetArray_west" and !isNil "radioNetArray_east" and !isNil "radioNetArray_guer" and !isNil "radioNetArray_civ"};

_radioNetArray = [];

switch (side player) do {
case WEST: {
		_radioNetArray = radioNetArray_west;
	};
case EAST: {
		_radioNetArray = radioNetArray_east;
	};
case RESISTANCE: {
		_radioNetArray = radioNetArray_guer;
	};
case CIVILIAN: {
		_radioNetArray = radioNetArray_civ;
	};
};

player createDiarySubject ["radioFrequencies", "Radio Frequencies"];
player createDiaryRecord ["radioFrequencies", ["Short Range Frequencies", format ["<br/>
<font color='#FFEC00'><font size='20'>COMMAND NET</font></font color> <br/>
Commander, Squad Leaders, Special  <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - %1</font color><font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>COMMAND</font><br/>
Commander + Medic             	           	  <font color='#FFEC00'>[</font color>Channel 5 - %2<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>ALPHA</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - %3</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - %3<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - %4<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - %5<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>BRAVO</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - %6</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - %6<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - %7<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - %8<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>CHARLIE</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - %9</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - %9<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - %10<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - %11<font color='#FFEC00'>]</font color><br/><br/><br/>

Radios are automatically set up for ease of use.<br/>
<font color='#FFEC00'>[</font color>CAPS<font color='#FFEC00'>]</font color> is bound for inter-group communication.<br/>
<font color='#FFEC00'>[</font color><font color='#8A8A8A'>T</font color><font color='#FFEC00'>]</font color> is bound for for higher-up communication.<br/>
Fireteam members do not have an alternative channel.<br/><br/>

<t underline='true'>IMPORTANT</t> - Remember the radio channels for your squad<br/>
so you can re-establish communications if leaders are KIA or missing.
", (_radioNetArray select 0) select 7, (_radioNetArray select 7) select 4, (_radioNetArray select 1) select 4, (_radioNetArray select 1) select 0, (_radioNetArray select 1) select 1, (_radioNetArray select 2) select 4, (_radioNetArray select 2) select 0, (_radioNetArray select 2) select 1, (_radioNetArray select 3) select 4, (_radioNetArray select 3) select 0, (_radioNetArray select 3) select 1]]];

_radio_channel = player getVariable ["radio_channel", [6, 4]];
_channel = _radio_channel select 0;
_team = _radio_channel select 1;

if (isNil {_radioNetArray select _channel}) exitWith {};

tf_freq_west = [_team - 1,7,radioNetArray_west select _channel,0,"_murshun",-1,0,"_SP_PLAYER_",false];
tf_freq_east = [_team - 1,7,radioNetArray_east select _channel,0,"_murshun",-1,0,"_SP_PLAYER_",false];
tf_freq_guer = [_team - 1,7,radioNetArray_guer select _channel,0,"_murshun",-1,0,"_SP_PLAYER_",false];

waitUntil {
	time > 0 and call TFAR_fnc_haveSWRadio
};

_currentSwRadio = call TFAR_fnc_activeSwRadio;

{
	[_currentSwRadio, _forEachIndex + 1, _x] call TFAR_fnc_SetChannelFrequency;
} foreach (_radioNetArray select _channel);

_className = tolower gettext (configFile >> "CfgVehicles" >> typeOf player >> "displayName");

[_currentSwRadio, _team - 1] call TFAR_fnc_setSwChannel;

if (_className == "officer" or _className == "squad leader") then {
	[_currentSwRadio, 8, (_radioNetArray select 0) select 7] call TFAR_fnc_SetChannelFrequency;
	[_currentSwRadio, 7] call TFAR_fnc_setAdditionalSwChannel;
};

if (_className == "team leader") then {
	[_currentSwRadio, 8, (_radioNetArray select 0) select 7] call TFAR_fnc_SetChannelFrequency;
	[_currentSwRadio, 4] call TFAR_fnc_setAdditionalSwChannel;
};
