if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	player createDiarySubject ["radioFrequencies", "Radio Settings"];
	player createDiaryRecord ["radioFrequencies", ["Channels", format ["<br/>
<font color='#FFEC00'><font size='20'>COMMAND NET</font></font color> <br/>
Commander, Squad Leaders, Pilots          <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC152 / Channel - 33</font color><font color='#FFEC00'>]</font color><br/>
<br/>
<font size='20'>COMMAND</font><br/>
Commander, Medic, Engineer, Fireteam Leaders          <font color='#FFEC00'>[</font color>PRC148 / Channel - 7<font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Special Weapons Team</font color>                          <font color='#FFEC00'>[</font color>PRC343 / Channel 7, Block 1<font color='#FFEC00'>]</font color><br/>
<br/>
<font size='20'>ALPHA</font><br/>
Squad Leader, Fireteam Leaders          <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC148 / Channel - 1</font color><font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Fireteam 1</font color>                          <font color='#FFEC00'>[</font color>PRC343 / Channel 1, Block 1<font color='#FFEC00'>]</font color><br/>
<font color='#00FF00'>Fireteam 2</font color>                          <font color='#FFEC00'>[</font color>PRC343 / Channel 1, Block 2<font color='#FFEC00'>]</font color><br/>
<br/>
<font size='20'>BRAVO</font><br/>
Squad Leader, Fireteam Leaders          <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC148 / Channel - 2</font color><font color='#FFEC00'>]</font color><br/>
<font color='#FF0000'>Fireteam 1</font color>                          <font color='#FFEC00'>[</font color>PRC343 / Channel 2, Block 1<font color='#FFEC00'>]</font color><br/>
<font color='#00FF00'>Fireteam 2</font color>                          <font color='#FFEC00'>[</font color>PRC343 / Channel 2, Block 2<font color='#FFEC00'>]</font color><br/>
<br/>
Radios are automatically set up for ease of use.<br/>
<br/>
<t underline='true'>IMPORTANT</t> - Use this radio channels table to re-establish communications if leaders are KIA or missing.
<br/>
"]]];
};
