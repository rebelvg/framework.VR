[] spawn {
	cutText ["", "BLACK FADED"];
	
	_startTime = time;	
	while {time < _startTime + 10} do {
		sleep (1/10);
		
		0 fadeSound 0;
		0 fadeMusic 0;
		ace_hearing_volumeAttenuation = 0;
	};
	
	0 fadeSound 1;
	0 fadeMusic 1;	
	ace_hearing_volumeAttenuation = 1;
};
