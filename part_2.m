clear; close all; clc; echo off

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N plan problem
N = 100;
plan = 1;
problem = 2;
options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3);
walk_plan = read_plan(plan); % read walking plan from file

% ----------------------------------------------------------------------- %
% INITIALIZE OPTIMIZATION PARAMETERS
% ----------------------------------------------------------------------- %
% p0 is the intitial parameter vector
x0 = zeros(1,N); % COM X
y0 = zeros(1,N); % COM Y
u_x0 = zeros(1,N); % COP X
u_y0 = zeros(1,N); % COP Y
st0 = walk_plan.duration';
p0=[x0 y0 u_x0 u_y0 st0]; % optimization vector

% ----------------------------------------------------------------------- %
% OPTIMIZE
% ----------------------------------------------------------------------- %
[answer,fval,exitflag]=fmincon(@cost_fun_2,p0,[],[],[],[],[],[],@constraint_fun_2,options);
fval
exitflag

% ----------------------------------------------------------------------- %
% PROCESS RESULTS
% ----------------------------------------------------------------------- %
R = treemaker(answer);
x = R.x;
y = R.y;
u_x = R.u_x;
u_y = R.u_y;
st = R.st; % step durations
p_x = walk_plan.p_x; % x desired foot locations
p_y = walk_plan.p_y; % y desired foot locations
step_dur = R.st; % step durations
time = R.time; % step occurance times
duration = R.duration; % sim duration
dt = R.dt; % time step
p_traj_x = walk_plan.p_traj_x; % x loaction of step for each sim time step
p_traj_y = walk_plan.p_traj_y; % y loaction of step for each sim time step

[xd,yd] = datderiv(x,y,dt); % x and y COM velocities

% ----------------------------------------------------------------------- %
% PLOT RESULTS
% ----------------------------------------------------------------------- %
fig(1) = figure();
hold on
plot(x,'b','linewidth',2)
plot(p_traj_x+u_x,'r','linewidth',2)
plot(p_traj_x,'c--','linewidth',2)
title('COM Trajectory in X')

fig(2) = figure();
hold on
plot(y,'b','linewidth',2)
plot(p_traj_y+u_y,'r--','linewidth',2)
plot(p_traj_y,'c--','linewidth',2)
title('COM Trajectory in Y')

fig(3) = figure();
hold on
plot(p_traj_x,p_traj_y,'r*')
plot(x,y,'b','linewidth',2)
title('XY COM Trajectory and Step Locations')

fig(4) = figure();
plot(xd,'g','linewidth',2)
title('COM X Velocity')

fig(5) = figure();
plot(yd,'y','linewidth',2)
title('COM Y Velocity')

fig(6) = figure();
subplot(2,1,1)
plot(u_x,'b','linewidth',2)
title('Ux')
subplot(2,1,2)
plot(u_y,'r','linewidth',2)
title('Uy')

scorecheck(answer); % show score breakdown
make_figs(fig); % print figures to files