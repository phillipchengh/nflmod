import nflexam
reload(nflexam)

# cat1 = ['passing_att', 'passing_cmp', 'passing_yds', 'passing_tds', 'passing_ratio', 'yards_per_pass', 'receiving_yac_yds', 'rushing_att', 'rushing_yds', 'rushing_tds', 'yards_per_rush']
# stats1 = nflexam.stats_all_teams_season(2013, cat1)
# nflexam.stats_csv(stats1, '../stats1.csv')

# cat2 = ['passing_tds', 'passing_int', 'passing_ratio', 'yards_per_pass', 'rushing_tds', 'yards_per_rush']
# stats2 = nflexam.stats_all_teams_season(2013, cat2)
# nflexam.stats_csv(stats2, '../stats2.csv')

# cat3 = ['passing_ratio', 'yards_per_pass', 'yards_per_rush']
# stats3 = nflexam.stats_all_teams_season(2013, cat3)
# nflexam.stats_csv(stats3, '../matlab/stats3.csv')

# cat4 = ['passing_att', 'passing_cmp', 'passing_yds', 'passing_tds', 'passing_int', 'passing_ratio', 'yards_per_pass', 'receiving_yac_yds', 'rushing_att', 'rushing_yds', 'rushing_tds', 'yards_per_rush', 'punting_yds', 'puntret_yds']
# stats4 = nflexam.stats_all_teams_season(2013, cat4)
# nflexam.stats_csv(stats4, '../matlab/stats4.csv')

# cat5 = ['passing_yds', 'passing_tds', 'passing_ratio', 'yards_per_pass', 'receiving_yac_yds', 'rushing_yds', 'rushing_tds', 'yards_per_rush', 'defense_int', 'fumbles_forced']
# stats5 = nflexam.stats_all_teams_season(2013, cat5)
# nflexam.stats_csv(stats5, '../matlab/stats5.csv')

# cat6 = ['passing_att', 'passing_cmp', 'passing_yds', 'passing_tds', 'passing_ratio', 'yards_per_pass', 'receiving_yac_yds', 'rushing_att', 'rushing_yds', 'rushing_tds', 'yards_per_rush', 'defense_int', 'fumbles_forced']
# stats6 = nflexam.stats_all_teams_season(2013, cat6)
# nflexam.stats_csv(stats6, '../matlab/stats6.csv')

# cat7 = ['passing_tds', 'passing_int', 'passing_ratio', 'yards_per_pass', 'rushing_tds', 'yards_per_rush', 'turnovers_taken', 'total_points']
# stats7 = nflexam.stats_all_teams_season(2013, cat7)
# nflexam.stats_csv(stats7, '../matlab/stats7.csv')

# cat8 = ['passing_tds', 'yards_per_pass', 'rushing_tds', 'yards_per_rush', 'turnovers_taken', 'total_points']
# stats8 = nflexam.stats_all_teams_season(2013, cat8)
# nflexam.stats_csv(stats8, '../matlab/stats8.csv')

cat8_home = ['passing_tds', 'yards_per_pass', 'rushing_tds', 'yards_per_rush', 'turnovers_taken', 'total_points']
stats8_home = nflexam.stats_all_teams_season(2013, cat8_home, home=True)
nflexam.stats_csv(stats8_home, '../matlab/stats8_home.csv')

cat8_away = ['passing_tds', 'yards_per_pass', 'rushing_tds', 'yards_per_rush', 'turnovers_taken', 'total_points']
stats8_away = nflexam.stats_all_teams_season(2013, cat8_away, away=True)
nflexam.stats_csv(stats8_away, '../matlab/stats8_away.csv')

