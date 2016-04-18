[] spawn {
	cutText ["", "BLACK FADED"];
	0 fadeSound 0;
	0 fadeMusic 0;
	_ace_volume = ace_hearing_volumeAttenuation;
	ace_hearing_volumeAttenuation = 0;
	sleep 10;
	0 fadeSound 1;
	0 fadeMusic 1;
	ace_hearing_volumeAttenuation = _ace_volume;
};
