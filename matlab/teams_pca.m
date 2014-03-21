function [stats_pca scores total explained max_info] = teams_pca(stats, year, k)
	% Plots each team's score and comparison with actual rankings.

	% Default number of principal components is the first k components that explain more than 1%.
	if nargin < 3
		% Default PCA.
		[stats_pca scores latent tsquared explained] = pca(stats);
		k = max(find(explained >= 1));
		k2 = k;
		fprintf('Default k: %i\n', k);
		[stats_pca scores latent tsquared explained] = pca(stats, 'NumComponents', k);
	end

	% If specified k, use that for PCA instead.
	if nargin >= 3
		[stats_pca scores latent tsquared explained] = pca(stats, 'NumComponents', k);
		k2 = max(find(explained >= 1));
	end

	% Default NFL season is 2013.
	if nargin < 2
		year = 2013;
		fprintf('Default year: 2013\n');
	end

	% Transpose for convenience.
	scores = scores';

	% Get number of teams.
	num_teams = size(stats, 1);

	% Calculate and append each team's total score.
	[scores max_idxs] = rank_teams(scores, stats_pca);

	% Insert each team's team_id at top in alphabetical order.
	scores = teams(scores);

	% Return total as each team's total score in an alphabetically ordered list.
	total = cell2mat(scores(k+2,:));

	% Sort each column by ascending total score.
	scores = sort_row(scores, k+2);

	% Return sorted_total as each team's total score in total_score ordered list.
	sorted_total = cell2mat(scores(k+2,:));

	% Plot each team's total score.
	figure
	plot(sorted_total, 'go')
	title('Sorted teams and their calculated total scores from rank-teams.')
	xlabel('Sorted teams')
	ylabel('Total score')
	text(1:size(sorted_total,2), sorted_total, scores(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
	xlim([1 num_teams])

	% Compare the calculated rankings with this year's draft order.
	[ix1 draft_order] = compare_draft(scores(1,:), year);

	% Calculate linear regression.
	x = ix1(1,:);
	y = ix1(2,:);
	p = polyfit(x, y, 1);
	yfit = polyval(p, x);
	yresid = y - yfit;
	SSresid = sum(yresid.^2);
	SStotal = (length(y)-1) * var(y);
	rsq = 1 - SSresid / SStotal;

	% Plot actual order vs. calculated order.
	figure
	plot(x, y, 'go')
	title(strcat('Comparison with the actual draft order:', num2str(year), '.'))
	xlabel('Draft order rankings')
	ylabel('PCA calculated rankings')
	text(1:size(ix1,2), y, draft_order, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
	text(26, 8, strcat('R^2=', num2str(rsq)), 'Color', 'r')
	hold on
	plot(1:num_teams, 1:num_teams)
	xlim([1 num_teams])
	l = legend('Teams', 'Expected');
	set(l, 'Location', 'SouthEast')

	% Plot explained.
	figure
	plot(explained, 'go')
	title('PCA percent variability.')
	xlabel('Principal component')
	ylabel('Percent explained')
	% Only display values equal or greater than 1%.
	text(1:k2, explained(1:k2), num2cell(explained(1:k2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')

	% Each row in max_info is [pc max_value row_index side explained]
	[pca_rows pca_cols] = size(stats_pca);
	[values idx] = max(stats_pca);
	max_info = zeros(pca_cols, 5);
	max_info(:, 1) = 1:pca_cols;
	max_info(:, 2) = values;
	max_info(:, 3) = idx;
	max_info(:, 4) = idx > pca_rows/2;
	max_info(:, 5) = explained(1:k2);