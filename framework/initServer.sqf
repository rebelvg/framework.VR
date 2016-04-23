[] spawn {
	waitUntil {!isNil "murshun_framework_generateRandomFreqs"};
	
	if (murshun_framework_generateRandomFreqs) then {
		_freqsPool = [];

		while {count _freqsPool < 1024} do {
			_random = str (floor (random [300, 1205, 5120]) / 10);
			
			if (!(_random in _freqsPool)) then {
				_freqsPool = _freqsPool + [_random];
			};
		};

		{
			_netArray = [];
			
			while {count _netArray < 8} do {
				_squadFreqs = [];
				
				while {count _squadFreqs < 8} do {
					_random = selectRandom _freqsPool;
					_squadFreqs = _squadFreqs + [_random];
					_freqsPool = _freqsPool - [_random];
				};
				
				_netArray = _netArray + [_squadFreqs];
			};
			
			missionNamespace setVariable [_x, _netArray];
		} foreach ["radioNetArray_west", "radioNetArray_east", "radioNetArray_guer", "radioNetArray_civ"];
	} else {
		radioNetArray_west = [["101", "102", "103", "104", "105", "106", "107", "108"], ["111", "112", "113", "114", "115", "116", "117", "118"], ["121", "122", "123", "124", "125", "126", "127", "128"], ["131", "132", "133", "134", "135", "136", "137", "138"], ["141", "142", "143", "144", "145", "146", "147", "148"], ["151", "152", "153", "154", "155", "156", "157", "158"], ["161", "162", "163", "164", "165", "166", "167", "168"], ["171", "172", "173", "174", "175", "176", "177", "178"]];

		radioNetArray_east = [["201", "202", "203", "204", "205", "206", "207", "208"], ["211", "212", "213", "214", "215", "216", "217", "218"], ["221", "222", "223", "224", "225", "226", "227", "228"], ["231", "232", "233", "234", "235", "236", "237", "238"], ["241", "242", "243", "244", "245", "246", "247", "248"], ["251", "252", "253", "254", "255", "256", "257", "258"], ["261", "262", "263", "264", "265", "266", "267", "268"], ["271", "272", "273", "274", "275", "276", "277", "278"]];

		radioNetArray_guer = [["301", "302", "303", "304", "305", "306", "307", "308"], ["311", "312", "313", "314", "315", "316", "317", "318"], ["321", "322", "323", "324", "325", "326", "327", "328"], ["331", "332", "333", "334", "335", "336", "337", "338"], ["341", "342", "343", "344", "345", "346", "347", "348"], ["351", "352", "353", "354", "355", "356", "357", "358"], ["361", "362", "363", "364", "365", "366", "367", "368"], ["371", "372", "373", "374", "375", "376", "377", "378"]];

		radioNetArray_civ = [["401", "402", "403", "404", "405", "406", "407", "408"], ["411", "412", "413", "414", "415", "416", "417", "418"], ["421", "422", "423", "424", "425", "426", "427", "428"], ["431", "432", "433", "434", "435", "436", "437", "438"], ["441", "442", "443", "444", "445", "446", "447", "448"], ["451", "452", "453", "454", "455", "456", "457", "458"], ["461", "462", "463", "464", "465", "466", "467", "468"], ["471", "472", "473", "474", "475", "476", "477", "478"]];
	};

	publicVariable "radioNetArray_west";
	publicVariable "radioNetArray_east";
	publicVariable "radioNetArray_guer";
	publicVariable "radioNetArray_civ";
};

if (!isNil "ZE_Zeus") then {
	if (isMultiplayer) then {
		deleteVehicle ZE_Zeus;
	};
};
