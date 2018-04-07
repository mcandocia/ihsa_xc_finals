URLS_2017 = {
	'girls': {
		'1A': r'http://www.raceresultsplus.com/sites/default/files/results/IHSA%20State%20Girls%201A%20Ind%20with%20Splits%20-%202017_0.htm',
		'2A': r'http://www.raceresultsplus.com/sites/default/files/results/IHSA%20State%20Girls%202A%20Ind%20with%20Splits%20-%202017_0.htm',
		'3A': r'http://www.raceresultsplus.com/sites/default/files/results/IHSA%20State%20Girls%203A%20Ind%20with%20Splits%20-%202017_0.htm',
	}, 
	'boys': {
	'1A': r'http://www.raceresultsplus.com/sites/default/files/results/IHSA%20State%20Boys%201A%20Ind%20with%20Splits%20-%202017%281%29.htm',
	'2A': r'http://www.raceresultsplus.com/sites/default/files/results/IHSA%20State%20Boys%203A%20Ind%20with%20Splits%20-%202017_0.htm',
	'3A': r'http://www.raceresultsplus.com/sites/default/files/results/IHSA%20State%20Boys%203A%20Ind%20with%20Splits%20-%202017_0.htm',

	}
}

URLS_2015 = {
	'girls': {
		'1A': 'http://www.raceresultsplus.com/sites/default/files/results/Girls%201A%20with%20Splits_0.htm',
		'2A': 'http://www.raceresultsplus.com/sites/default/files/results/Girls%202A%20with%20Splits_0.htm',
		'3A': 'http://www.raceresultsplus.com/sites/default/files/results/Girls%203A%20with%20Splits_0.htm',

	}, 
	'boys': {
		'1A': 'http://www.raceresultsplus.com/sites/default/files/results/Boys%201A%20with%20Splits_0.htm',
		'2A': 'http://www.raceresultsplus.com/sites/default/files/results/Boys%202A%20with%20Splits_0.htm',
		'3A': 'http://www.raceresultsplus.com/sites/default/files/results/Boys%203A%20with%20Splits_0.htm',
	}
}

URLS_2016 = {
	'girls': {
		'1A': 'http://www.raceresultsplus.com/sites/default/files/results/2016_IHSA_State_Finals_Girls1A_OverallwSplits.htm',
		'2A': 'http://www.raceresultsplus.com/sites/default/files/results/2016_IHSA_State_Finals_Girls2A_OverallwSplits.htm',
		'3A': 'http://www.raceresultsplus.com/sites/default/files/results/2016_IHSA_State_Finals_Girls3A_OverallwSplits.htm',
	},
	'boys': {
		'1A': 'http://www.raceresultsplus.com/sites/default/files/results/2016_IHSA_State_Finals_Boys1A_OverallwSplits.htm',
		'2A': 'http://www.raceresultsplus.com/sites/default/files/results/2016_IHSA_State_Finals_Boys2A_OverallwSplits.htm',
		'3A': 'http://www.raceresultsplus.com/sites/default/files/results/2016_IHSA_State_Finals_Boys3A_OverallwSplits.htm',
	}
}

# note - standing = freshman, sophomore, junior, senior (i.e., year in school)
COLUMN_POSITIONS = {
	2015: {
		'place':1,
		'name': 2,
		'team': 3,
		'bib_number': 4,
		'gender': 5,
		'rank_1_mile': 6,
		'time_1_mile': 7,
		'rank_1.5_mile': 8,
		'time_1.5_mile': 9,
		'rank_2_mile': 10,
		'time_2_mile': 11,
		'rank_3_mile': 12,
		'time_3_mile': 13,
		'time_overall': 14,
	},

	2016: {
		'place': 1,
		'name': 2, 
		'city': 3,
		'bib_number': 4,
		'age': 5,
		'gender': 6,
		'age group': 7,
		'rank_1_mile': 8,
		'time_1_mile': 9,
		'rank_1.5_mile': 10,
		'time_1.5_mile': 11,
		'rank_2_mile': 12,
		'time_2_mile': 13,
		'rank_3_mile': 14,
		'time_3_mile': 15,
		'time_overall': 16,
		'time_overall_gun': 17,
		'pace_overall': 18,
	},

	2017: {
		'place': 1,
		'adjusted_place': 2,
		'bib_number': 3,
		'name': 4,
		'team': 5,
		'time_1_mile': 6,
		'time_1.5_mile': 7,
		'time_2_mile': 8,
		'time_overall': 9,
		'pace': 10,
		'standing': 11,
		'unused': 12,

	}
}

INDIVIDUAL_COLUMN_POSITIONS_2015 = {
	'place': 1,
	'adjusted_place': 2,
	'bib_number': 3,
	'name': 4,
	'team': 5,
	'time': 6,
	'pace': 7, 
	'standing': 8,
	'unused': 9,

}

NON_SPLIT_URLS_2015 = {
	'girls': {
		'1A': 'http://www.raceresultsplus.com/sites/default/files/results/Girls%201A%20Individual.htm',
		'2A': 'http://www.raceresultsplus.com/sites/default/files/results/Girls%202A%20Individual.htm',
		'3A': 'http://www.raceresultsplus.com/sites/default/files/results/Girls%203A%20Individual.htm',
	}, 

	'boys': {
		'1A': 'http://www.raceresultsplus.com/sites/default/files/results/Boys%201A%20Individual.htm',
		'2A': 'http://www.raceresultsplus.com/sites/default/files/results/Boys%202A%20Individual.htm',
		'3A': 'http://www.raceresultsplus.com/sites/default/files/results/Boys%203A%20Individual_1.htm',
	}
}