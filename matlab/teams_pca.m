function [scores total] = teams_pca(stats, year, k)
	% Plots each team's score and comparison with actual rankings.

	stats_pca = pca(stats);
	num_teams = size(stats, 1);
	scores = zeros(k, 32);

	% Calculate scores by multipling with stats and pca weights.
	for i = 1:num_teams
		for j = 1:k
			scores(j, i) = stats(i,:)*stats_pca(:,j);
		end
	end

	% Append each team's total score.
	scores = rank_teams(scores, stats_pca);

	% Insert each team's team_id at top in alphabetical order.
	scores = teams(scores);

	% Return total as each team's total score in an alphabetical ordered list.
	total = cell2mat(scores(k+2,:));

	% Sort each column by ascending total score.
	scores = sort_row(scores, k+2);
	sorted_total = cell2mat(scores(k+2,:));

	% Plot each team's total score.
	% figure
	% plot(sorted_total, 'go')
	% text(1:size(sorted_total,2), sorted_total, scores(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')

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
	xlabel('Actual rankings in terms of draft order.')
	ylabel(strcat('PCA calculated rankings for ', num2str(year), '.'))
	text(1:size(ix1,2), y, draft_order, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
	text(26, 4, strcat('R^2=',num2str(rsq)), 'Color', 'r')
	hold on
	plot(1:32, 1:32)