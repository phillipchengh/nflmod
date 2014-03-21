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

draft_2012 = {
 'IND'
 'STL'
 'MIN'
 'CLE'
 'TB'
 'WAS'
 'JAC'
 'MIA'
 'CAR'
 'BUF'
 'KC'
 'SEA'
 'ARI'
 'DAL'
 'PHI'
 'NYJ'
 'OAK'
 'SD'
 'CHI'
 'TEN'
 'CIN'
 'ATL'
 'DET'
 'PIT'
 'DEN'
 'HOU'
 'NO'
 'GB'
 'BAL'
 'SF'
 'NE'
 'NYG'
}';

draft_2011 = {
 'CAR'
 'DEN'
 'BUF'
 'CIN'
 'ARI'
 'CLE'
 'SF'
 'TEN'
 'DAL'
 'WAS'
 'HOU'
 'MIN'
 'DET'
 'STL'
 'MIA'
 'JAC'
 'OAK'
 'SD'
 'NYG'
 'TB'
 'KC'
 'IND'
 'PHI'
 'NO'
 'SEA'
 'ATL'
 'BAL'
 'NE'
 'CHI'
 'NYJ'
 'PIT'
 'GB'
}';

draft_2010 = {
 'STL'
 'DET'
 'TB'
 'WAS'
 'KC'
 'SEA'
 'CLE'
 'OAK'
 'BUF'
 'JAC'
 'CHI'
 'MIA'
 'SF'
 'DEN'
 'NYG'
 'TEN'
 'CAR'
 'PIT'
 'ATL'
 'HOU'
 'CIN'
 'NE'
 'GB'
 'PHI'
 'BAL'
 'ARI'
 'DAL'
 'SD'
 'NYJ'
 'MIN'
 'IND'
 'NO'
}';

if year == 2013
	draft = draft_2014;
elseif year == 2012
	draft = draft_2013;
elseif year == 2011
	draft = draft_2012;
elseif year == 2010
	draft = draft_2011;
elseif year == 2009
	draft = draft_2010;
else
	draft = draft_2014;
end

num_teams = size(order, 2);

C = zeros(2, num_teams);

% The first row of C is the original calculated order in increasing strength.
% The second row of C is the actual draft order in increasing strength.
for i = 1:num_teams
	C(1, i) = i;
	C(2, i) = find(ismember(order, draft(i)));
end