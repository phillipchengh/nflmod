function [R idx] = rank_teams(stats, pca)
% Roughly rank each team by adding team scores and subtracting opposing team scores.

	[stats_rows stats_teams] = size(stats);
	[pca_rows pca_cols] = size(pca);

	% Get each maximum of each pca column.
	[C idx] = max(pca);

	% Total scores will be appended to stats.
	R = cat(1, stats, zeros(1, stats_teams));

	for i = 1:stats_teams
		for j = 1:stats_rows
			% If the maximum index indicates the opposing team's score, then subtract the value of it.
			if idx(j) > pca_rows/2
				R(stats_rows+1,i) = R(stats_rows+1,i) - stats(j, i);
				R(j, i) = -stats(j, i);
			% If the maximum index indicates the team's score, then add the value of it.
			else
				R(stats_rows+1,i) = R(stats_rows+1,i) + stats(j, i);
			end
		end
	end