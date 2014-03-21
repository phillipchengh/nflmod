function R = rank_teams(stats, pca)
	[stats_rows stats_teams] = size(stats);
	[pca_rows pca_cols] = size(pca);
	abs_stats = abs(stats);
	[C idx] = max(pca());
	R = cat(1, stats, zeros(1, stats_teams));
	for i = 1:stats_teams
		for j = 1:stats_rows
			if idx(j) > pca_cols/2
				R(stats_rows+1,i) = R(stats_rows+1,i) - abs_stats(j, i);
				R(j, i) = -abs_stats(j, i);
			else
				R(stats_rows+1,i) = R(stats_rows+1,i) + abs_stats(j, i);
			end
		end
	end