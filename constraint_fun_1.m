function [ineq_violations,eq_violations] = constraint_fun(p)
global N plan

walk_plan = read_plan(plan); % read walking plan from file
p_x = walk_plan.p_x;
p_y = walk_plan.p_y;
stance = walk_plan.stance_type;
step_dur = walk_plan.duration;
time = walk_plan.time;

vmin_x = -100; % bs inequality constraint so it'll run


duration = sum(step_dur);
dt = duration/N;
z = 1; % set height to constant
G = 9.81; % gravity


i_x0 = 1;
i_y0 = i_x0 + N + 1;
i_u_x0 = i_y0 + N + 1;
i_u_y0 = i_u_x0 + N + 1;

x=p(i_x0:i_x0+N);
y=p(i_y0:i_y0+N);
u_x=p(i_u_x0:i_u_x0+N);
u_y=p(i_u_y0:i_u_y0+N);

% equality constraints
idx = 1; % equality constraint index
step = 1;
count = 1;
% dynamics
for i = 1:N-1
    if dt*count >= time(step)
        step = step+1;
    end
    ddx = (x(i+1+1)-2*x(i+1)+x(i-1+1))/(dt^2); % calculate acceleration
    eq_violations(idx) = ddx - (x(i) - p_x(step) + u_x(i)) * G/z; % enforce F = ma
    idx = idx+1;
    count = count+1;
end

step = 1;
count = 1;
for i = 1:N-1
    if dt*count >= time(step)
        step = step+1;
    end
    ddy = (y(i+1+1)-2*y(i+1)+y(i-1+1))/(dt^2); % calculate acceleration
    eq_violations(idx) = ddy - (y(i) - p_y(step) + u_y(i)) * G/z; % enforce F = ma
    idx = idx+1;
    count = count+1;
end

% inequality constraints
idx = 1;
for i=1:N-1
    ineq_violations(idx)=-(x(i+1+1)-x(i-1+1))/(2*dt)+vmin_x; % bs stuff
    idx=idx+1;
end


end
