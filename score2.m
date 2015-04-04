function [score, score_vec] = score2(p)
global N plan

% VARIABLES
walk_plan = read_plan(plan); % read walking plan from file
R = treemaker(p);
x = R.x;
y = R.y;
u_x = R.u_x;
u_y = R.u_y;
st = R.st;
p_x = walk_plan.p_x; % x foot locations
p_y = walk_plan.p_y; % y foot locations
step_dur = R.st;
time = R.time;
duration = R.duration;
dt = R.dt;
p_traj_x = walk_plan.p_traj_x;
p_traj_y = walk_plan.p_traj_y;


% CALCULATIONS
v_av = p_x(end)/duration; % average velocity
[xd,yd] = datderiv(x,y,dt);
avstep_vec = ones(1,length(step_dur))*mean(step_dur)-step_dur;


% SCORE
s_original = 0;
s_vav = 0;
s_avstep = 0;

for i = 1:length(xd)
    s_original = s_original + (x(i) - p_traj_x(i))^2 + xd(i)^2 + 30*u_x(i)^2 + (y(i) - p_traj_y(i))^2 + yd(i)^2 + 30*u_y(i)^2;
    s_vav = s_vav + 1*(v_av-xd(i))^2;
end
s_avstep = s_avstep + 1.2*N*(avstep_vec*avstep_vec');

score_vec = [s_original, s_avstep, s_vav];
score = sum(score_vec);