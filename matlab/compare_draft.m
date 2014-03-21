function [C draft] = compare_draft(order, year)

draft_2014 = {
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

draft_2013 = {
 'KC'
 'JAC'
 'OAK'
 'PHI'
 'DET'
 'CLE'
 'ARI'
 'BUF'
 'NYJ'
 'TEN'
 'SD'
 'MIA'
 'TB'
 'CAR'
 'NO'
 'STL'
 'PIT'
 'DAL'
 'NYG'
 'CHI'
 'CIN'
 'WAS'
 'MIN'
 'IND'
 'SEA'
 'GB'
 'HOU'
 'DEN'
 'NE'
 'ATL'
 'SF'
 'BAL'
}';

if year == 2013
	draft = draft_2014;
elseif year == 2012
	draft = draft_2013;
else
	draft = draft_2014;
end
num_teams = size(order, 2);
C = zeros(2, num_teams);
for i = 1:num_teams
	C(1, i) = i;
	C(2, i) = find(ismember(order, draft(i)));
end