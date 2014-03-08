function S = sort_row(stats, k)
	[Y, I] = sort(cell2mat(stats(k,:)));
	S = stats(:,I);