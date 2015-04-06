function [ineq_violations,eq_violations] = constraint_fun_3(p)
global N plan

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
walk_plan = read_plan(plan); % read walking plan from file
R = treemaker(p);
x = R.x;
y = R.y;
u_x = R.u_x;
u_y = R.u_y;
st = R.st;
slx = R.slx; % x foot locations
sly = R.sly; % y foot locations
p_x_d = walk_plan.p_x; % x desired foot locations
p_y_d = walk_plan.p_y; % y desired foot locations
step_dur = R.st;
time = R.time;
duration = R.duration;
dt = R.dt;
p_traj_x = R.p_traj_x;
p_traj_y = R.p_traj_y;
z = 1; % set height to constant
G = 9.81; % gravity


% ----------------------------------------------------------------------- %
% EQUALITY CONSTRAINTS
% ----------------------------------------------------------------------- %
idx = 1; % equality constraint index
% dynamics
for i = 1:length(x)-2
    ddx = (x(i+2)-2*x(i+1)+x(i))/(dt^2); % calculate acceleration
    eq_violations(idx) = ddx - ((x(i) - p_traj_x(i) + u_x(i)) * G/z); % enforce F = ma
    idx = idx+1;
end

for i = 1:length(y)-2
    ddy = (y(i+2)-2*y(i+1)+y(i))/(dt^2); % calculate acceleration
    eq_violations(idx) = ddy - ((y(i) - p_traj_y(i) + u_y(i)) * G/z); % enforce F = ma
    idx = idx+1;
end
eq_violations(idx) = slx(1); % first step x at 0
idx = idx+1;
eq_violations(idx) = sly(1); % first step y at 0
idx = idx+1;

idx = 1;
for i=1:length(st)
    ineq_violations(idx) = -st(i); % step durations > 0
    idx=idx+1;
end

ineq_violations(idx) = p_x_d(end) - slx(end); % final step x must be >= desired
idx=idx+1;

ineq_violations(idx) = time(end) - walk_plan.time(end); % end time must be <= original plan end time