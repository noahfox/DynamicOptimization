clear; close all; clc; echo on

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N plan
N = 100;
plan = 1;
rng('shuffle','twister')
options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3);




% p0 is the intitial parameter vector
x0 = rand(1,N+1);
y0 = rand(1,N+1);
u_x0 = zeros(1,N+1);
u_y0 = zeros(1,N+1);
p0=[x0 y0 u_x0 u_y0]; % a0 u0


[answer,fval,exitflag]=fmincon(@cost_fun,p0,[],[],[],[],[],[],@constraint_fun,options);

fval
exitflag


i_x0 = 1;
i_y0 = i_x0 + N + 1;
i_u_x0 = i_y0 + N + 1;
i_u_y0 = i_u_x0 + N + 1;


walk_plan = read_plan(plan); % read walking plan from file
p_x = walk_plan.p_x;
p_y = walk_plan.p_y;
stance = walk_plan.stance_type;
step_dur = walk_plan.duration;
time = walk_plan.time;
duration = sum(step_dur);
dt = duration/N;

step = 1;
for i = 1:1:N-1
    if dt*i >= time(step)
        step = step+1;
    end
    p_traj_x(i) = p_x(step);
    p_traj_y(i) = p_y(step);
end

fig(1) = figure();
hold on
plot(answer(i_x0:i_x0+N),'b','linewidth',2)
plot(answer(i_u_x0:i_u_x0+N),'r','linewidth',2)
plot(p_traj_x,'c--','linewidth',2)
title('COM Trajectory in X')

fig(2) = figure();
hold on
plot(answer(i_y0:i_y0+N),'b','linewidth',2)
plot(answer(i_u_y0:i_u_y0+N),'r--','linewidth',2)
plot(p_traj_y,'c--','linewidth',2)
title('COM Trajectory in Y')


