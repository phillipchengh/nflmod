function S = teams_pca(stats, k)
	stats_pca = pca(stats);
	num_teams = size(stats, 1);
	S = zeros(k, 32);
	for i = 1:num_teams
		for j = 1:k
			S(j, i) = stats(i,:)*stats_pca(:,j);
		end
	end
	S = rank_teams(S);
	S = teams(S);
	S = sort_row(S, k+2);
	scores = cell2mat(S(k+2,:));
	figure
	plot(scores, 'go')
	text(1:size(scores,2), scores, S(1,:), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
	[ix1 draft_order] = compare_draft(S(1,:));
	figure
	plot(ix1(1,:), ix1(2,:), 'go')
	text(1:size(ix1,2), ix1(2,:), draft_order, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
	hold on
	plot(1:32, 1:32)