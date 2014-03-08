function R = rank_teams(stats)
	[num_rows num_teams] = size(stats);
	abs_stats = abs(stats);
	R = cat(1, stats, zeros(1, num_teams));
	for i = 1:num_teams
		for j = 1:num_rows
			if mod(j,2) == 1
				R(num_rows+1,i) = R(num_rows+1,i) + abs_stats(j, i);
			else
				R(num_rows+1,i) = R(num_rows+1,i) - abs_stats(j, i);
			end
		end
	end

