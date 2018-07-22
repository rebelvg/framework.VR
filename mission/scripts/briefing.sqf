//0 = [] execVM "mission\scripts\briefing.sqf";

private _missionBriefing = "Mission Briefing<br/><br/><img height=128 image='klpq_framework\logo.paa'/><br/>";
player createDiaryRecord ["diary", ["Mission", _missionBriefing]];
