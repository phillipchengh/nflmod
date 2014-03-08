import nfldb
import csv

db = nfldb.connect()

teams = []

with nfldb.Tx(db) as cursor:
	cursor.execute('''
SELECT team_id FROM team WHERE team_id != 'UNK' ORDER BY team_id
''')
	for row in cursor.fetchall():
		teams.append(row.get('team_id'))

def stats_csv(stats, filename='stats.csv'):
	"""Writes csv to filename from the 2D list of stats. Each list is written as a row, with col_names optional."""
	with open(filename, 'wb') as csv_file:
		stat_writer = csv.writer(csv_file, dialect='excel', delimiter=',')
		for row in stats:
			stat_writer.writerow(row)

def stats_all_teams_season(season_year, cat, transpose=False):
	"""Return a list of season stat rows with cat categories corresponding to each NFL team."""
	stats = []
	for team in teams:
		stats += [stats_team_season(season_year, cat, team)]
	if transpose:
		stats = [list(row) for row in zip(*stats)]	
	return stats

def stats_team_season(season_year, cat, team):
	"""Return a stat row with cat categories corresponding to team."""
	q = nfldb.Query(db)
	q.game(season_year=season_year, season_type='Regular', team=team)
	players = q.play(team=team).as_aggregate()
	stats_row = []
	stats_row += stats_query(players, cat)
	q2 = nfldb.Query(db)
	q2.game(season_year=season_year, season_type='Regular', team=team)
	away_players = q2.play(team__ne=team).as_aggregate()
	stats_row += stats_query(away_players, cat)
	return stats_row

def stats_query(players, cat):
	"""Return a stat row corresponding to the list of categories of input players, including non-nfldb stats."""
	return stats_custom(players, cat, stats_nfldb_query(players, cat))

def stats_nfldb_query(players, cat):
	"""Return a stat row corresponding to the list of categories of input players. Non-nfldb stats are set to 0."""
	players = [[getattr(pp, c) if hasattr(pp, c) else 0 for c in cat] for pp in players]
	stats = [0] * len(cat)
	# sum up the stats from each player
	for pp in players:
		for (i, stat) in enumerate(pp):
			stats[i] += stat
	return stats

def stats_custom(players, cat, stats):
	"""Return a stat row with non-nfldb stats filled in."""
	for (i, c) in enumerate(cat):
		if c == 'passing_ratio':
			stats[i] = stats_passing_ratio(players)
		elif c == 'yards_per_pass':
			stats[i] = stats_yards_per_pass(players)
		elif c == 'yards_per_rush':
			stats[i] = stats_yards_per_rush(players)
	return stats

def stats_passing_ratio(players):
	"""Return passing_ratio from players."""
	cat = ['passing_att', 'passing_cmp']
	stats = stats_nfldb_query(players, cat)
	if stats[0] == 0:
		return 0
	else:
		return (round(float(stats[1]) / stats[0], 2))

def stats_yards_per_pass(players):
	"""Return yards_per_pass from players."""
	cat = ['passing_att', 'passing_yds']
	stats = stats_nfldb_query(players, cat)
	if stats[0] == 0:
		return 0
	else:
		return (round(float(stats[1]) / stats[0], 2))

def stats_yards_per_rush(players):
	"""Return yards_per_rush from players."""
	cat = ['rushing_att', 'rushing_yds']
	stats = stats_nfldb_query(players, cat)
	if stats[0] == 0:
		return 0
	else:
		return (round(float(stats[1]) / stats[0], 2))

def stats_passing(players):
	"""Return [passing_att, passing_cmp, passing_yds, passing_tds, passing_int, passing_ratio, yards_per_pass] of input PlayPlayers."""
	cat = ['passing_att', 'passing_cmp', 'passing_yds', 'passing_tds', 'passing_int']
	# filter players with non-zero attempts
	players = [[getattr(pp, c) for c in cat] for pp in players if getattr(pp, cat[0]) != 0]
	stats = [0] * len(cat)
	# sum up the stats from each player
	for pp in players:
		for (i, stat) in enumerate(pp):
			stats[i] += stat
	if stats[0] == 0:
		stats.append(0)
		return stats
	else:
		# calculate passing_ratio
		stats.append(round(float(stats[1]) / stats[0], 2))
		# calculate yards_per_pass
		stats.append(round(float(stats[2]) / stats[0], 2))
		return stats

def stats_receiving(players):
	"""Return [receiving_tar, receiving_rec, receiving_yds, receiving_yac_yds, receiving_tds, receiving_ratio] of input PlayPlayers."""
	cat = ['receiving_tar', 'receiving_rec', 'receiving_yds', 'receiving_yac_yds', 'receiving_tds']
	# filter players with non-zero attempts
	players = [[getattr(pp, c) for c in cat] for pp in players if getattr(pp, cat[0]) != 0]
	stats = [0] * len(cat)
	# sum up the stats from each player
	for pp in players:
		for (i, stat) in enumerate(pp):
			stats[i] += stat
	if stats[0] == 0:
		stats.append(0)
		return stats
	else:
		# calculate receiving_ratio
		stats.append(round(float(stats[1]) / stats[0], 2))
		return stats

def stats_rushing(players):
	"""Return [rushing_att, rushing_yds, rushing_tds, yards_per_rush] of input PlayPlayers."""
	# bug? for some reason everyone has 0 rushing_loss and rushing_loss_yds
	cat = ['rushing_att', 'rushing_yds', 'rushing_tds']
	# filter players with non-zero attempts
	players = [[getattr(pp, c) for c in cat] for pp in players if getattr(pp, cat[0]) != 0]
	stats = [0] * len(cat)
	# sum up the stats from each player
	for pp in players:
		for (i, stat) in enumerate(pp):
			stats[i] += stat
	if stats[0] == 0:
		stats.append(0)
		return stats
	else:
		# calculate yards_per_rush
		stats.append(round(float(stats[1]) / stats[0], 2))
		return stats

def stats_team_week(season_year, team, headers=False):
	"""Return a list of length 16 (weeks). Each element is a list of stat rows from team."""
	stats = []
	q = nfldb.Query(db)
	games = q.game(season_year=season_year, season_type='Regular', team=team).sort(('gsis_id', 'asc')).as_games()
	if headers:
		col_names = []
		col_names += ['passing_att', 'passing_cmp', 'passing_yds', 'passing_tds', 'passing_int', 'passing_ratio', 'yards_per_pass']
		col_names += ['receiving_yac_yds']
		col_names += ['rushing_att', 'rushing_yds', 'rushing_tds', 'yards_per_rush']
		stats.append(col_names)
	for g in games:
		players = team_players(g.gsis_id, team)
		stats_row = []
		stats_row += stats_passing(players)
		stats_row += stats_query(players, ['receiving_yac_yds'])
		stats_row += stats_rushing(players)
		stats.append(stats_row)
	return stats

def regular_season(season_year, team):
	"""Print team's regular season games."""
	q = nfldb.Query(db)
	q.game(season_year=season_year, season_type='Regular', team=team).sort(('gsis_id', 'asc'))
	for g in q.as_games():
		print g
	return q

def drives(season_year, team, week):
	"""Print team's drives in that week."""
	q = nfldb.Query(db)
	q.game(season_year=season_year, season_type='Regular', team=team, week=week)
	drives = q.drive(pos_team=team).sort(('start_time', 'asc'))
	for drive in drives.as_drives():
		print drive
	return q	

def gsis_id(season_year, team, week):
	"""Return the gsis_id from the given game info."""
	q = nfldb.Query(db)
	q.game(season_year=season_year, season_type='Regular', team=team, week=week)
	game = q.as_games()
	if len(game) == 0:
		return -1
	else:
		return game[0].gsis_id

def team_players(gsis_id, team):
	"""Return the team's [PlayPlayers] in game gsis_id."""
	q = nfldb.Query(db)
	q.game(gsis_id=gsis_id)
	q.play(team=team)
	return q.as_aggregate()