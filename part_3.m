clear; close all; clc; echo off

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N plan problem
N = 100;
plan = 1;
problem = 3;
options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3,'MaxIter',750);
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
sl0 = [walk_plan.p_x' walk_plan.p_y'];
p0=[x0 y0 u_x0 u_y0 st0 sl0]; % optimization vector

% ----------------------------------------------------------------------- %
% OPTIMIZE
% ----------------------------------------------------------------------- %
[answer,fval,exitflag]=fmincon(@cost_fun_3,p0,[],[],[],[],[],[],@constraint_fun_3,options);
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
st = R.st;
p_x = R.slx; % x foot locations
p_y = R.sly; % y foot locations
p_x_d = walk_plan.p_x; % x desired foot locations
p_y_d = walk_plan.p_y; % y desired foot locations
step_dur = R.st;
time = R.time;
duration = R.duration;
dt = R.dt;
p_traj_x = R.p_traj_x;
p_traj_y = R.p_traj_y;

[xd,yd] = datderiv(x,y,dt);

% ----------------------------------------------------------------------- %
% PLOT RESULTS
% ----------------------------------------------------------------------- %
fig(1) = figure();
hold on
plot(x,'linewidth',2)
plot(p_traj_x+u_x,'linewidth',2)
plot(p_traj_x,'--','linewidth',2)
title('COM Trajectory in X')

fig(2) = figure();
hold on
plot(y,'linewidth',2)
plot(p_traj_y+u_y,'--','linewidth',2)
plot(p_traj_y,'--','linewidth',2)
title('COM Trajectory in Y')

fig(3) = figure();
hold on
plot(p_traj_x,p_traj_y,'*')
plot(x,y,'linewidth',2)
title('XY COM Trajectory and Step Locations')

fig(4) = figure();
plot(xd,'linewidth',2)
title('COM X Velocity')

fig(5) = figure();
plot(yd,'linewidth',2)
title('COM Y Velocity')

fig(6) = figure();
subplot(2,1,1)
plot(u_x,'linewidth',2)
title('Ux')
subplot(2,1,2)
plot(u_y,'linewidth',2)
title('Uy')

fig(7) = figure();
hold on
plot(p_x_d,p_y_d,'o')
plot(p_x,p_y,'*')
title('Footstep Locaitons')
legend('Desired','Optimized','location','best')

scorecheck(answer); % show score breakdown
make_figs(fig); % print figures to files