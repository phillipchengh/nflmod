import nflexam

# For convenience when reload(example) in ipython.
reload(nflexam)

path_file_name = '../matlab/data'
path_file_name2 = '../matlab/data5_'

cats = [
# data1.csv
['passing_att', 'passing_cmp', 'passing_yds', 'passing_tds', 'passing_ratio', 'yards_per_pass', 'receiving_yac_yds', 'rushing_att', 'rushing_yds', 'rushing_tds', 'yards_per_rush'],

# data2.csv
['passing_ratio', 'yards_per_pass', 'yards_per_rush'],

# data3.csv
['passing_tds', 'passing_ratio', 'yards_per_pass', 'rushing_tds', 'yards_per_rush', 'punting_tot', 'punting_i20', 'kicking_fgm', 'defense_tkl_loss', 'defense_sk', 'defense_safe', 'defense_pass_def', 'defense_int', 'defense_ffum'],

# data4.csv
['passing_tds', 'yards_per_pass', 'rushing_tds', 'yards_per_rush', 'turnovers_taken', 'total_points'],

# data5.csv
['passing_tds_points', 'rushing_tds_points', 'defense_tds_points', 'kicking_fgm_points', 'kicking_xpmade_points', 'passing_twoptm_points', 'rushing_twoptm_points', 'defense_safe_points']
]

# data1.csv to data5.csv are generated here.
# for (i, cat) in enumerate(cats):
# 	data = nflexam.stats_all_teams_season(2013, cat)
# 	nflexam.stats_csv(data, path_file_name + str(i+1) + '.csv')

# data5_2009.csv to data5_2013.csv are generated here.
# for i in range(0, 5):
# 	data = nflexam.stats_all_teams_season(2009+i, cats[4])
# 	nflexam.stats_csv(data, path_file_name2 + str(2009+i) + '.csv')

# data5_home.csv and data5_away.csv are generated here.
data = nflexam.stats_all_teams_season(2013, cats[4], home=True, away=False)
nflexam.stats_csv(data, '../matlab/data5_home.csv')

data = nflexam.stats_all_teams_season(2013, cats[4], home=False, away=True)
nflexam.stats_csv(data, '../matlab/data5_away.csv')

# Helper function for identifying the stat category given the index.
def get_cat(cat, index):
	one_cat = cat-1;
	double_cat = cats[one_cat] + cats[one_cat]
	return double_cat[index-1]