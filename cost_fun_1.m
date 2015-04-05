function score = cost_fun_1(p)
global N plan

% ----------------------------------------------------------------------- %
% READ AND PROCESS PARAMETERS
% ----------------------------------------------------------------------- %
walk_plan = read_plan(plan); % read walking plan from file
p_x = walk_plan.p_x; % x foot locations
p_y = walk_plan.p_y; % y foot locations
stance = walk_plan.stance_type; % stance type
step_dur = walk_plan.duration; % step durations
time = walk_plan.time; % sim time of each step

duration = sum(step_dur); % calculate sim duration
dt = duration/N; % sim time step

% ----------------------------------------------------------------------- %
% PROCESS OPTIMIZED PARAMETERS
% ----------------------------------------------------------------------- %
% p vector indecies
i_x0 = 1;
i_y0 = i_x0 + N + 1;
i_u_x0 = i_y0 + N + 1;
i_u_y0 = i_u_x0 + N + 1;

% process p vector into variables
x=p(i_x0:i_x0+N);
y=p(i_y0:i_y0+N);
u_x=p(i_u_x0:i_u_x0+N);
u_y=p(i_u_y0:i_u_y0+N);

% ----------------------------------------------------------------------- %
% CALCULATE SCORE
% ----------------------------------------------------------------------- %

score = 0; % initialize score

% compute score
step = 1;
for i = 1:N-1
    if dt*i >= time(step)
        step = step+1;
    end
    xd = (x(i+1+1)-x(i))/(2*dt); % COM velocity in x
    yd = (y(i+1+1)-y(i))/(2*dt); % COM velocity in y
    % cost function
    score = score + (x(i) - p_x(step))^2 + xd^2 + 30*u_x(i)^2 + (y(i) - p_y(step))^2 + yd^2 + 30*u_y(i)^2; 
end
end