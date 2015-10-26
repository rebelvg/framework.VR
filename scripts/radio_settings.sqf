waituntil {!isNil "radioNetArray"};

murshun_assignTeam_fnc = {
_unit = _this select 0;
_radio_channel = _unit getVariable ["radio_channel", [1, 0]];

_squad = _radio_channel select 0;
_team = _radio_channel select 1;

_teamsArray = ["MAIN", "RED", "GREEN", "BLUE", "YELLOW"];

waituntil {time > 10};

if (_team == 0) exitWith {};
if (_team > 4) exitWith {systemChat "Can't set color for this team.";};

[[_unit, _teamsArray select _team], "ace_interaction_fnc_joinTeam"] call BIS_fnc_MP;
};

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
<font color='#99E699'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 132<font color='#FFEC00'>]</font color><br/><br/><br/>

Radios are automatically set up for ease of use.<br/>
<font color='#FFEC00'>[</font color>CAPS<font color='#FFEC00'>]</font color> is bound for inter-group communication.<br/>
<font color='#FFEC00'>[</font color><font color='#8A8A8A'>T</font color><font color='#FFEC00'>]</font color> is bound for for higher-up communication.<br/>
Fireteam members do not have an alternative channel.<br/><br/>

<t underline='true'>IMPORTANT</t> - Remember the radio channels for your squad<br/>
so you can re-establish communications if leaders are KIA or missing.
"]];

waituntil {
_haveRadio = call TFAR_fnc_haveSWRadio;
_unableUseRadio = player getVariable ["tf_unable_to_use_radio", false];
_haveRadio or _unableUseRadio
};

_unableUseRadio = player getVariable ["tf_unable_to_use_radio", false];

if (_unableUseRadio) exitWith {};

_radio_channel = player getVariable ["radio_channel", [1, 0]];
_channel = _radio_channel select 0;
_team = _radio_channel select 1;

[(call TFAR_fnc_activeSwRadio), 1, (radioNetArray select _channel) select 0] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 2, (radioNetArray select _channel) select 1] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 3, (radioNetArray select _channel) select 2] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 4, (radioNetArray select _channel) select 3] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 5, (radioNetArray select _channel) select 4] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 6, (radioNetArray select _channel) select 5] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 7, (radioNetArray select _channel) select 6] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 8, (radioNetArray select _channel) select 7] call TFAR_fnc_SetChannelFrequency;

if (_team != 0) then {
[(call TFAR_fnc_activeSwRadio), _team - 1] call TFAR_fnc_setSwChannel;
};

_className = tolower gettext (configFile >> "cfgVehicles" >> typeOf player >> "displayName");

if (_team == 0) then {
	[(call TFAR_fnc_activeSwRadio), 1, (radioNetArray select _channel) select 7] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 2, (radioNetArray select 0) select 1] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 3, (radioNetArray select 0) select 2] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 4, (radioNetArray select 0) select 3] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 5, (radioNetArray select 0) select 4] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 6, (radioNetArray select 0) select 5] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 7, (radioNetArray select 0) select 6] call TFAR_fnc_SetChannelFrequency;	
	[(call TFAR_fnc_activeSwRadio), 8, (radioNetArray select 0) select 7] call TFAR_fnc_SetChannelFrequency;
	if (_className == "squad leader") then {
	[(call TFAR_fnc_ActiveSWRadio), 7] call TFAR_fnc_setAdditionalSwChannel;
	};
};

if (_className == "team leader") then {
	[(call TFAR_fnc_ActiveSWRadio), 7] call TFAR_fnc_setAdditionalSwChannel;
};

[player] spawn murshun_assignTeam_fnc;
