function [ineq_violations,eq_violations] = constraint_fun_2(p)
global N plan

% % % i_x0 = 1;
% % % i_y0 = i_x0 + N + 1;
% % % i_u_x0 = i_y0 + N + 1;
% % % i_u_y0 = i_u_x0 + N + 1;
% % % i_st0 = i_u_y0 + N + 1;
% % % 
% % % x=p(i_x0:i_x0+N);
% % % y=p(i_y0:i_y0+N);
% % % u_x=p(i_u_x0:i_u_x0+N);
% % % u_y=p(i_u_y0:i_u_y0+N);
% % % st=p(i_st0:i_st0+7);

% % % p_x = walk_plan.p_x;
% % % p_y = walk_plan.p_y;
% stance = walk_plan.stance_type;
% % % step_dur = st;
% % % time(1) = step_dur(1);
% % % for i = 2:1:length(step_dur)
% % %     time(i) = time(i-1) + step_dur(i);
% % % end
% % % 
% % % duration = sum(step_dur);
% % % dt = duration/N;

walk_plan = read_plan(plan); % read walking plan from file
R = treemaker(p);
x = R.x;
y = R.y;
u_x = R.u_x;
u_y = R.u_y;
st = R.st;
p_x = walk_plan.p_x; % x desired foot locations
p_y = walk_plan.p_y; % y desired foot locations
step_dur = R.st;
time = R.time;
duration = R.duration;
dt = R.dt;
p_traj_x = walk_plan.p_traj_x;
p_traj_y = walk_plan.p_traj_y;
z = 1; % set height to constant
G = 9.81; % gravity


% equality constraints
idx = 1; % equality constraint index
% % % step = 1;
% % % count = 1;
% dynamics
for i = 1:length(x)-2
% % %     if dt*count >= time(step)
% % %         step = step+1;
% % %     end
    ddx = (x(i+2)-2*x(i+1)+x(i))/(dt^2); % calculate acceleration
    eq_violations(idx) = ddx - ((x(i) - p_traj_x(i) + u_x(i)) * G/z); % enforce F = ma
    idx = idx+1;
% % %     count = count+1;
end

% % % step = 1;
% % % count = 1;
for i = 1:length(y)-2
% % %     if dt*count >= time(step)
% % %         step = step+1;
% % %     end
    ddy = (y(i+2)-2*y(i+1)+y(i))/(dt^2); % calculate acceleration
    eq_violations(idx) = ddy - ((y(i) - p_traj_y(i) + u_y(i)) * G/z); % enforce F = ma
    idx = idx+1;
% % %     count = count+1;
end


% inequality constraints
idx = 1;
for i=1:length(st)
    ineq_violations(idx) = -st(i);
    idx=idx+1;
end

ineq_violations(idx) = time(end) - walk_plan.time(end);


end
