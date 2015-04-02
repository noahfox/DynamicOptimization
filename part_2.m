clear; close all; clc; echo off

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N plan
N = 100;
plan = 1;

rng('shuffle','twister')
options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3);

walk_plan = read_plan(plan); % read walking plan from file

% ----------------------------------------------------------------------- %
% INITIALIZE OPTIMIZATION PARAMETERS
% ----------------------------------------------------------------------- %
% p0 is the intitial parameter vector
x0 = rand(1,N+1); % COM X
y0 = rand(1,N+1); % COM Y
u_x0 = zeros(1,N+1); % COP X
u_y0 = zeros(1,N+1); % COP Y
st = walk_plan.duration';
p0=[x0 y0 u_x0 u_y0 st]; % optimization vector

% ----------------------------------------------------------------------- %
% OPTIMIZE
% ----------------------------------------------------------------------- %
[answer,fval,exitflag]=fmincon(@cost_fun_2,p0,[],[],[],[],[],[],@constraint_fun_2,options);
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
i_st0 = i_u_y0 + N + 1;

x=answer(i_x0:i_x0+N);
y=answer(i_y0:i_y0+N);
u_x=answer(i_u_x0:i_u_x0+N);
u_y=answer(i_u_y0:i_u_y0+N);
st=answer(i_st0:i_st0+7);

p_x = walk_plan.p_x; % x foot locations
p_y = walk_plan.p_y; % y foot locations
stance = walk_plan.stance_type;
step_dur = walk_plan.duration;
step_dur = st;
time(1) = step_dur(1);
for i = 2:1:length(step_dur)
    time(i) = time(i-1) + step_dur(i);
end
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

for i = 1:N-1
    xd(i) = (x(i+1+1)-x(i))/(2*dt); % COM velocity in x
    yd(i) = (y(i+1+1)-y(i))/(2*dt); % COM velocity in x
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

fig(3) = figure();
hold on
plot(p_traj_x,p_traj_y,'r*')
plot(answer(i_x0:i_x0+N),answer(i_y0:i_y0+N),'b','linewidth',2)
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
