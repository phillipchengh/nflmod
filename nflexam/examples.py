import nflexam

cat1 = ['passing_att', 'passing_cmp', 'passing_yds', 'passing_tds', 'passing_int', 'passing_ratio', 'yards_per_pass', 'receiving_yac_yds', 'rushing_att', 'rushing_yds', 'rushing_tds', 'yards_per_rush']
stats1 = nflexam.stats_all_teams_season(2013, cat1)
nflexam.stats_csv(stats1, '../stats1.csv')

cat2 = ['passing_tds', 'passing_int', 'passing_ratio', 'yards_per_pass', 'rushing_tds', 'yards_per_rush']
stats2 = nflexam.stats_all_teams_season(2013, cat2)
nflexam.stats_csv(stats2, '../stats2.csv')

cat3 = ['passing_ratio', 'yards_per_pass', 'yards_per_rush']
stats3 = nflexam.stats_all_teams_season(2013, cat3)
nflexam.stats_csv(stats3, '../matlab/stats4.csv')

