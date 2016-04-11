waitUntil {!isNil "murshun_frameworkInit"};

player createDiarySubject ["radioFrequencies", "Radio Frequencies"];

player createDiaryRecord ["radioFrequencies", ["Radio Frequencies", "<br/>
<font color='#FFEC00'><font size='20'>COMMAND NET</font></font color> <br/>
Commander, Squad Leaders, Special  <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 108</font color><font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>COMMAND</font><br/>
Commander + Medic             	           	  <font color='#FFEC00'>[</font color>Channel 5 - 175<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>ALPHA</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 115</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - 115<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 111<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 112<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>BRAVO</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 125</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - 125<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 121<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 122<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>CHARLIE</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 135</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - 135<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 131<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 132<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>DELTA</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 145</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - 145<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 141<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 142<font color='#FFEC00'>]</font color><br/><br/><br/>

Radios are automatically set up for ease of use.<br/>
<font color='#FFEC00'>[</font color>CAPS<font color='#FFEC00'>]</font color> is bound for inter-group communication.<br/>
<font color='#FFEC00'>[</font color><font color='#8A8A8A'>T</font color><font color='#FFEC00'>]</font color> is bound for for higher-up communication.<br/>
Fireteam members do not have an alternative channel.<br/><br/>

<t underline='true'>IMPORTANT</t> - Remember the radio channels for your squad<br/>
so you can re-establish communications if leaders are KIA or missing.
"]];

waitUntil {
	time > 0 and call TFAR_fnc_haveSWRadio
};

_currentSwRadio = call TFAR_fnc_activeSwRadio;
_radio_channel = player getVariable ["radio_channel", [6, 4]];
_channel = _radio_channel select 0;
_team = _radio_channel select 1;

if (isNil {radioNetArray select _channel}) exitWith {};

{
	[_currentSwRadio, _forEachIndex + 1, _x] call TFAR_fnc_SetChannelFrequency;
} foreach (radioNetArray select _channel);

_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf player >> "displayName");

[_currentSwRadio, _team - 1] call TFAR_fnc_setSwChannel;

if (_className == "officer" or _className == "squad leader") then {
	[_currentSwRadio, 8, (radioNetArray select 0) select 7] call TFAR_fnc_SetChannelFrequency;
	[_currentSwRadio, 7] call TFAR_fnc_setAdditionalSwChannel;
};

if (_className == "team leader") then {
	[_currentSwRadio, 8, (radioNetArray select 0) select 7] call TFAR_fnc_SetChannelFrequency;
	[_currentSwRadio, 4] call TFAR_fnc_setAdditionalSwChannel;
};

[player] spawn murshun_assignTeam_fnc;
