clear; close all; clc; echo off

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N plan problem
N = 100;
plan = 1;
problem = 3;

rng('shuffle','twister')
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
% indecies for different parameter sets
% % % i_x0 = 1;
% % % i_y0 = i_x0 + N + 1;
% % % i_u_x0 = i_y0 + N + 1;
% % % i_u_y0 = i_u_x0 + N + 1;
% % % i_st0 = i_u_y0 + N + 1;
% % % i_slx0 = i_st0 + 8;
% % % i_sly0 = i_slx0 + 8;

% % % x=answer(i_x0:i_x0+N);
% % % y=answer(i_y0:i_y0+N);
% % % u_x=answer(i_u_x0:i_u_x0+N);
% % % u_y=answer(i_u_y0:i_u_y0+N);
% % % st=answer(i_st0:i_st0+7);
% % % slx=answer(i_slx0:i_slx0+7);
% % % sly=answer(i_sly0:i_sly0+7);

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
% stance = walk_plan.stance_type;
step_dur = R.st;
time = R.time;
duration = R.duration;
dt = R.dt;
p_traj_x = R.p_traj_x;
p_traj_y = R.p_traj_y;

% % % step = 1;
% % % for i = 1:1:N
% % %     if dt*i > time(step)
% % %         step = step+1;
% % %     end
% % %     p_traj_x(i+1) = p_x(step); % make trajectory of steps in x
% % %     p_traj_y(i+1) = p_y(step); % make trajectory of steps in y
% % % end


% % % for i = 1:N-2
% % %     xd(i) = (x(i+1+1)-x(i))/(2*dt); % COM velocity in x
% % %     yd(i) = (y(i+1+1)-y(i))/(2*dt); % COM velocity in x
% % % end
[xd,yd] = datderiv(x,y,dt);

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

fig(7) = figure();
hold on
plot(p_x_d,p_y_d,'ro')
plot(p_x,p_y,'b*')
title('Footstep Locaitons')
legend('Desired','Optimized','location','best')

scorecheck(answer);
