waitUntil {!isNil "murshun_frameworkInit"};

player createDiarySubject ["radioFrequencies", "Radio Frequencies"];

player createDiaryRecord ["radioFrequencies", ["Radio Frequencies", "<br/>
<font color='#FFEC00'><font size='20'>COMMAND NET</font></font color> <br/>
Commander, Squad Leaders, Special  <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 108</font color><font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>COMMAND</font><br/>
Commander + Medic             	           	  <font color='#FFEC00'>[</font color>Channel 1 - 178<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>ALPHA</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 118</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 8 - 118<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 111<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 112<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>BRAVO</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 128</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 8 - 128<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 121<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 122<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>CHARLIE</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 138</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 8 - 138<font color='#FFEC00'>]</font color><br/>
<font color='#FF9980'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 131<font color='#FFEC00'>]</font color><br/>
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 132<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>DELTA</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 148</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 8 - 148<font color='#FFEC00'>]</font color><br/>
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
	call TFAR_fnc_haveSWRadio;
};

_currentSwRadio = call TFAR_fnc_activeSwRadio;
_radio_channel = player getVariable ["radio_channel", [6, 0]];
_channel = _radio_channel select 0;
_team = _radio_channel select 1;

if (_channel >= count radioNetArray) exitWith {};

_i = 1;
{
	[_currentSwRadio, _i, _x] call TFAR_fnc_SetChannelFrequency;
	_i = _i + 1;
} foreach (radioNetArray select _channel);

_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf player >> "displayName");

if (_team == 0) then {
	[_currentSwRadio, 1, (radioNetArray select _channel) select 7] call TFAR_fnc_SetChannelFrequency;
	[_currentSwRadio, 8, (radioNetArray select 0) select 7] call TFAR_fnc_SetChannelFrequency;
} else {
	[_currentSwRadio, _team - 1] call TFAR_fnc_setSwChannel;
};

if (_className == "officer" or _className == "squad leader" or _className == "team leader") then {
	[_currentSwRadio, 7] call TFAR_fnc_setAdditionalSwChannel;
};

[player] spawn murshun_assignTeam_fnc;
