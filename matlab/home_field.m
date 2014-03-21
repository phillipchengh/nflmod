function home_stats = home_field(stats_home, stats_away, k)
	% Plots each team's score and comparison with actual rankings.

	stats_pca_home = pca(stats_home);
	stats_pca_away = pca(stats_away);
	num_teams = size(stats_home, 1);
	scores_home = zeros(k, 32);
	scores_away = zeros(k, 32);

	% Calculate scores by multipling with stats and pca weights.
	for i = 1:num_teams
		for j = 1:k
			scores_home(j, i) = stats_home(i,:)*stats_pca_home(:,j);
			scores_away(j, i) = stats_away(i,:)*stats_pca_away(:,j);
		end
	end

	% Append each team's total score.
	scores_home = rank_teams(scores_home, stats_pca_home);
	scores_away = rank_teams(scores_away, stats_pca_away);

	% Return total as each team's total score in an alphabetical ordered list.
	total_home = scores_home(k+1,:);
	total_away = scores_away(k+1,:);

	% Construct home stats.
	home_stats = [total_home; total_away; total_home-total_away];
	home_stats = teams(home_stats);

	% Sort each column by ascending total score.
	home_stats = sort_row(home_stats, 4);
	sorted_total = cell2mat(home_stats(4,:));

	figure
	plot(sorted_total, 'go')
	text(1:size(sorted_total,2), sorted_total, home_stats(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
	
	% Sort by ascending home score.
	sorted_home = sort_row(home_stats, 2);
	sorted_total = cell2mat(sorted_home(2,:));

	figure
	plot(sorted_total, 'r+')
	text(1:size(sorted_total,2), sorted_total, sorted_home(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')

	% Sort by ascending home score.
	sorted_away = sort_row(home_stats, 3);
	sorted_total = cell2mat(sorted_away(3,:));

	hold on
	plot(sorted_total, 'b*')
	text(1:size(sorted_total,2), sorted_total, sorted_away(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')

	l = legend('Home', 'Away');
	set(l, 'Location', 'SouthEast')