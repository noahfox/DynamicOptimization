function fig = scorecheck(solution)
global problem

% ----------------------------------------------------------------------- %
% EVALUATE SCORE FOR PROBLEM 2
% ----------------------------------------------------------------------- %
if problem == 2
    [score,score_vec] = score2(solution); % run problem specific score function
    
    names = {'Original', 'X Step Similarity', 'Average Velocity',}; % cost function terms
    fig_title = sprintf('Score: %g',score);
    
    % pie chart of cost function terms
    fig(1) = figure();
    pie(score_vec,names);
    title(fig_title)
    
    % bar chart of cost function terms
    fig(2) = figure();
    bar(score_vec);
    set(gca, 'XTick', 1:length(names), 'XTickLabel', names);
    title(fig_title)
    
% ----------------------------------------------------------------------- %
% EVALUATE SCORE FOR PROBLEM 3
% ----------------------------------------------------------------------- %
elseif problem == 3
    [score,score_vec] = scoreme(solution); % run problem specific score function
    
    names = {'Original', 'X Step Similarity', 'Average Velocity', 'X Foot Position', 'Y Foot Position', 'Average Y Position'};
    fig_title = sprintf('Score: %g',score);
    
    % pie chart of cost function terms
    fig(1) = figure();
    pie(score_vec,names);
    title(fig_title)
    
    % bar chart of cost function terms
    fig(2) = figure();
    bar(score_vec);
    set(gca, 'XTick', 1:length(names), 'XTickLabel', names);
    title(fig_title)
end
end