clear; close all; clc; echo on

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N plan
N = 100;
plan = 1;
rng('shuffle','twister')
options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3);

% ----------------------------------------------------------------------- %
% INITIALIZE OPTIMIZATION PARAMETERS
% ----------------------------------------------------------------------- %
% p0 is the intitial parameter vector
x0 = rand(1,N+1); % COM X
y0 = rand(1,N+1); % COM Y
u_x0 = zeros(1,N+1); % COP X
u_y0 = zeros(1,N+1); % COP Y
p0=[x0 y0 u_x0 u_y0]; % optimization vector

% ----------------------------------------------------------------------- %
% OPTIMIZE
% ----------------------------------------------------------------------- %
[answer,fval,exitflag]=fmincon(@cost_fun,p0,[],[],[],[],[],[],@constraint_fun,options);
fval
exitflag

% ----------------------------------------------------------------------- %
% PROCESS RESULTS
% ----------------------------------------------------------------------- %
% indecies for different parameter sets
i_x0 = 1;
i_y0 = i_x0 + N + 1;
i_u_x0 = i_y0 + N + 1;
i_u_y0 = i_u_x0 + N + 1;


walk_plan = read_plan(plan); % read walking plan from file
p_x = walk_plan.p_x; % x foot locations
p_y = walk_plan.p_y; % y foot locations
stance = walk_plan.stance_type;
step_dur = walk_plan.duration;
time = walk_plan.time;
duration = sum(step_dur);
dt = duration/N;

step = 1;
for i = 1:1:N
    if dt*i > time(step)
        step = step+1;
    end
    p_traj_x(i+1) = p_x(step); % make trajectory of steps in x
    p_traj_y(i+1) = p_y(step); % make trajectory of steps in y
end

fig(1) = figure();
hold on
plot(answer(i_x0:i_x0+N),'b','linewidth',2)
plot(p_traj_x+answer(i_u_x0:i_u_x0+N),'r','linewidth',2)
plot(p_traj_x,'c--','linewidth',2)
title('COM Trajectory in X')

fig(2) = figure();
hold on
plot(answer(i_y0:i_y0+N),'b','linewidth',2)
plot(p_traj_y+answer(i_u_y0:i_u_y0+N),'r--','linewidth',2)
plot(p_traj_y,'c--','linewidth',2)
title('COM Trajectory in Y')


