function fig = scorecheck(solution)

[score,score_vec] = scoreme(solution);

names = {'Original', 'X Step Similarity', 'Average Velocity', 'X Foot Position', 'Y Foot Position', 'Average Y Position'};
fig_title = sprintf('Score: %g',score);

fig(1) = figure();
pie(score_vec,names);
title(fig_title)

fig(2) = figure();
bar(score_vec);
set(gca, 'XTick', 1:length(names), 'XTickLabel', names);
title(fig_title)
end