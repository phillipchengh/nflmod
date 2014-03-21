function home_stats = home_field(stats_home, stats_away)
	% Plots each team's score and comparison with actual rankings.

	% PCA and scores. Uses only components with >= 1% variance.
	[stats_pca_home scores_home latent tsquared explained1] = pca(stats_home);
	[stats_pca_away scores_away latent tsquared explained2] = pca(stats_away);
	k1 = max(find(explained1 >= 1));
	k2 = max(find(explained2 >= 1));
	k = min([k1 k2]);
	fprintf('Default k: %i\n', k);
	[stats_pca_home scores_home latent tsquared explained] = pca(stats_home, 'NumComponents', k);
	[stats_pca_away scores_away latent tsquared explained] = pca(stats_away, 'NumComponents', k);

	num_teams = size(stats_home, 1);

	% Transpose for convenience.
	scores_home = scores_home'
	scores_away = scores_away'

	% Append each team's total score.
	scores_home = rank_teams(scores_home, stats_pca_home);
	scores_away = rank_teams(scores_away, stats_pca_away);

	% Return total as each team's total score in an alphabetical ordered list.
	total_home = scores_home(k+1,:);
	total_away = scores_away(k+1,:);

	% Construct home stats.
	home_stats = [total_home; total_away; abs(total_home-total_away)];
	home_stats = teams(home_stats);

	% Sort each column by ascending total score.
	home_stats = sort_row(home_stats, 4);
	sorted_total = cell2mat(home_stats(4,:));

	figure
	plot(sorted_total, 'go')
	title(strcat('Ascending disparity with home vs. away.'))
	xlabel('Sorted teams')
	ylabel('Disparity')
	text(1:size(sorted_total,2), sorted_total, home_stats(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
	
	sorted_total = cell2mat(home_stats(2,:));

	figure
	plot(sorted_total, 'r+')
	title('Inline home vs. away comparison.')
	xlabel('Sorted teams')
	ylabel('Total score')
	text(1:size(sorted_total,2), sorted_total, home_stats(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')

	sorted_total = cell2mat(home_stats(3,:));

	hold on
	plot(sorted_total, 'b*')
	text(1:size(sorted_total,2), sorted_total, home_stats(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')

	l = legend('Home', 'Away');
	set(l, 'Location', 'SouthEast')