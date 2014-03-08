function [C names] = compare_draft(order)

names = {
 'HOU'
 'WAS'
 'JAC'
 'CLE'
 'OAK'
 'ATL'
 'TB'
 'MIN'
 'BUF'
 'DET'
 'TEN'
 'NYG'
 'STL'
 'CHI'
 'PIT'
 'DAL'
 'BAL'
 'NYJ'
 'MIA'
 'ARI'
 'GB'
 'PHI'
 'KC'
 'CIN'
 'SD'
 'IND'
 'NO'
 'CAR'
 'NE'
 'SF'
 'DEN'
 'SEA'
}';

num_teams = size(order, 2);
C = zeros(2, num_teams);
for i = 1:num_teams
	C(1, i) = i;
	C(2, i) = find(ismember(order, names(i)));
end