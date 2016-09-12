if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	player createDiarySubject ["radioFrequencies", "Radio Frequencies"];
	player createDiaryRecord ["radioFrequencies", ["Short Range Frequencies", format ["<br/>
<font color='#FFEC00'><font size='20'>COMMAND NET</font></font color> <br/>
Commander, Squad Leaders, Special  <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC152 / Channel - 1</font color><font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>COMMAND</font><br/>
Commander + Medic             	           	  <font color='#FFEC00'>[</font color>PRC148 / Channel - 7<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>ALPHA</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC148 / Channel - 1</font color><font color='#FFEC00'>]</font color><br/>
Engineer + Medic                <font color='#FFEC00'>[</font color>PRC148 / Channel - 1<font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>PRC343 / Channel 1, Block 1<font color='#FFEC00'>]</font color><br/>
<font color='#00FF00'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>PRC343 / Channel 1, Block 2<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>BRAVO</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC148 / Channel - 2</font color><font color='#FFEC00'>]</font color><br/>
Engineer + Medic                <font color='#FFEC00'>[</font color>PRC148 / Channel - 2<font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>PRC343 / Channel 2, Block 1<font color='#FFEC00'>]</font color><br/>
<font color='#00FF00'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>PRC343 / Channel 2, Block 2<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>CHARLIE</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC148 / Channel - 3</font color><font color='#FFEC00'>]</font color><br/>
Engineer + Medic                <font color='#FFEC00'>[</font color>PRC148 / Channel - 3<font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>PRC343 / Channel 3, Block 1<font color='#FFEC00'>]</font color><br/>
<font color='#00FF00'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>PRC343 / Channel 3, Block 2<font color='#FFEC00'>]</font color><br/><br/><br/>

Radios are automatically set up for ease of use.<br/>
Fireteam members do not have an alternative channel.<br/><br/>

<t underline='true'>IMPORTANT</t> - Remember the radio channels for your squad<br/>
so you can re-establish communications if leaders are KIA or missing."]]];
};

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	player createDiarySubject ["radioFrequencies", "Radio Frequencies"];
	player createDiaryRecord ["radioFrequencies", ["Short Range Frequencies", format ["<br/>
<font color='#FFEC00'><font size='20'>COMMAND NET</font></font color> <br/>
Commander, Squad Leaders, Special  <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 108</font color><font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>COMMAND</font><br/>
Commander + Medic             	           	  <font color='#FFEC00'>[</font color>Channel 5 - 175<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>ALPHA</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 115</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - 115<font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 111<font color='#FFEC00'>]</font color><br/>
<font color='#00FF00'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 112<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>BRAVO</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 125</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - 125<font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 121<font color='#FFEC00'>]</font color><br/>
<font color='#00FF00'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 122<font color='#FFEC00'>]</font color><br/><br/>

<font size='20'>CHARLIE</font><br/>
Squad Leader + Fireteam Leaders    <font color='#FFEC00'>[</font color><font color='#8A8A8A'>Alt Channel - 135</font color><font color='#FFEC00'>]</font color><br/>
Squad Leader + Medic                <font color='#FFEC00'>[</font color>Channel 5 - 135<font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Fireteam 1</font color>                           	<font color='#FFEC00'>[</font color>Channel 1 - 131<font color='#FFEC00'>]</font color><br/>
<font color='#00FF00'>Fireteam 2</font color>                            <font color='#FFEC00'>[</font color>Channel 2 - 132<font color='#FFEC00'>]</font color><br/><br/><br/>

Radios are automatically set up for ease of use.<br/>
<font color='#FFEC00'>[</font color>CAPS<font color='#FFEC00'>]</font color> is bound for inter-group communication.<br/>
<font color='#FFEC00'>[</font color><font color='#8A8A8A'>T</font color><font color='#FFEC00'>]</font color> is bound for for higher-up communication.<br/>
Fireteam members do not have an alternative channel.<br/><br/>

<t underline='true'>IMPORTANT</t> - Remember the radio channels for your squad<br/>
so you can re-establish communications if leaders are KIA or missing."]]];
};
