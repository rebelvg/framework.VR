if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	player createDiarySubject ["radioFrequencies", "Radio Settings"];
	player createDiaryRecord ["radioFrequencies", ["Channels", format ["<br/>
<font color='#FFEC00'><font size='20'>COMMAND NET</font></font color> <br/>
Commander, Squad Leaders, Pilots          <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC152 / Channel - 1</font color><font color='#FFEC00'>]</font color><br/>
<br/>
<font size='20'>COMMAND</font><br/>
Commander, Medic, Engineer          <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC343 / Channel - 7</font color><font color='#FFEC00'>]</font color><br/>
<br/>
<font size='20'>ALPHA</font><br/>
Squad Leader, Fireteams          <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC343 / Channel - 1</font color><font color='#FFEC00'>]</font color><br/>
<br/>
<font size='20'>BRAVO</font><br/>
Squad Leader, Fireteams          <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC343 / Channel - 2</font color><font color='#FFEC00'>]</font color><br/>
<br/>
<font size='20'>SPECIAL WEAPONS</font><br/>
Squad Leader, Fireteams          <font color='#FFEC00'>[</font color><font color='#8A8A8A'>PRC343 / Channel - 3</font color><font color='#FFEC00'>]</font color><br/>
<br/>
Radios are automatically set up for ease of use.<br/>
<br/>
<t underline='true'>IMPORTANT</t> - Use this radio channels table to re-establish communications if leaders are KIA or missing.
<br/>
"]]];
};
