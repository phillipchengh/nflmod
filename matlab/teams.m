function N = teams(stats)
names = {
 'ARI'
 'ATL'
 'BAL'
 'BUF'
 'CAR'
 'CHI'
 'CIN'
 'CLE'
 'DAL'
 'DEN'
 'DET'
 'GB'
 'HOU'
 'IND'
 'JAC'
 'KC'
 'MIA'
 'MIN'
 'NE'
 'NO'
 'NYG'
 'NYJ'
 'OAK'
 'PHI'
 'PIT'
 'SD'
 'SEA'
 'SF'
 'STL'
 'TB'
 'TEN'
 'WAS'
}';

N = cat(1, names, num2cell(stats));