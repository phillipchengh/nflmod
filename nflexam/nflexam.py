import nfldb
import csv

db = nfldb.connect()

def stats_csv(stats):
	"""Writes a csv file from the 2D list of stats. Each list is written as a row."""
	with open('stats.csv', 'wb') as csv_file:
		stat_writer = csv.writer(csv_file, dialect='excel', delimiter=',')
		for row in stats:
			stat_writer.writerow(row)

def stats_team(season_year, team):
	"""Returns a list of length 16 (weeks) of a stats list from input team."""
	stats = []
	q = nfldb.Query(db)
	games = q.game(season_year=season_year, season_type='Regular', team=team).sort(('gsis_id', 'asc')).as_games()
	for g in games:
		fielded = team_players(g.gsis_id, team)
		stats_row = stats_passing(fielded)# + stats_rushing(fielded)
		stats.append(stats_row)
	# uncomment to transpose the stats
	# stats = [list(row) for row in zip(*stats)]
	return stats

def stats_passing(fielded):
	"""Returns [passing_att, passing_cmp, passing_tds, passing_int, passing_ratio] of input PlayPlayers."""
	cat = ['passing_att', 'passing_cmp', 'passing_tds', 'passing_int']
	# filter players with non-zero stats in above categories
	players = [[getattr(pp, c) for c in cat] for pp in fielded if getattr(pp, cat[0]) != 0]
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
		return stats

def stats_rushing(fielded):
	"""Returns [rushing_att, rushing_yds, rushing_tds, rushing_loss, yards_per_rush] of input PlayPlayers."""
	cat = ['rushing_att', 'rushing_yds', 'rushing_tds', 'rushing_loss']
	# filter players with non-zero stats in above categories
	players = [[getattr(pp, c) for c in cat] for pp in fielded if getattr(pp, cat[0]) != 0]
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

def regular_season(season_year, team):
	q = nfldb.Query(db)
	q.game(season_year=season_year, season_type='Regular', team=team).sort(('gsis_id', 'asc'))
	for g in q.as_games():
		print g
	return q

def drives(season_year, team, week):
	q = nfldb.Query(db)
	q.game(season_year=season_year, season_type='Regular', team=team, week=week)
	drives = q.drive(pos_team=team).sort(('start_time', 'asc'))
	for drive in drives.as_drives():
		print drive
	return q	

def gsis_id(season_year, team, week):
	q = nfldb.Query(db)
	q.game(season_year=season_year, season_type='Regular', team=team, week=week)
	game = q.as_games()[0]
	return game.gsis_id

def team_players(gsis_id, team):
	"""Returns the team's [PlayPlayers] in game gsis_id."""
	q = nfldb.Query(db)
	q.game(gsis_id=gsis_id)
	players = q.as_aggregate()
	players = [pp for pp in players if pp.player.team == team]
	return players
