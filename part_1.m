clear; close all; clc; echo on

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N plan problem
N = 100;
plan = 1;
problem = 1;

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
[answer,fval,exitflag]=fmincon(@cost_fun_1,p0,[],[],[],[],[],[],@constraint_fun_1,options);
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

% process parameters
walk_plan = read_plan(plan); % read walking plan from file
p_x = walk_plan.p_x; % x foot locations
p_y = walk_plan.p_y; % y foot locations
stance = walk_plan.stance_type;
step_dur = walk_plan.duration;
time = walk_plan.time;
duration = sum(step_dur);
dt = duration/N;

% process solution into variables
x=answer(i_x0:i_x0+N);
y=answer(i_y0:i_y0+N);
u_x=answer(i_u_x0:i_u_x0+N);
u_y=answer(i_u_y0:i_u_y0+N);

% calculate COM velocities
[xd,yd] = datderiv(x,y,dt);

step = 1;
for i = 1:1:N
    if dt*i > time(step)
        step = step+1;
    end
    p_traj_x(i+1) = p_x(step); % make trajectory of steps in x
    p_traj_y(i+1) = p_y(step); % make trajectory of steps in y
end

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
plot(x,y,'linewidth',2)
plot(p_x,p_y,'*')
title('COM Trajectory with Foot Locations')
legend('COM Trajectory', 'Foot Locations','location','best')

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

make_figs(fig); % print figures to files