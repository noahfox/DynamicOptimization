function score = cost_fun(p)

global N plan

i_x0 = 1;
i_y0 = i_x0 + N + 1;
i_u_x0 = i_y0 + N + 1;
i_u_y0 = i_u_x0 + N + 1;
i_st0 = i_u_y0 + N + 1;
i_slx0 = i_st0 + 8;
i_sly0 = i_slx0 + 8;

x=p(i_x0:i_x0+N);
y=p(i_y0:i_y0+N);
u_x=p(i_u_x0:i_u_x0+N);
u_y=p(i_u_y0:i_u_y0+N);
st=p(i_st0:i_st0+7);
slx=p(i_slx0:i_slx0+7);
sly=p(i_sly0:i_sly0+7);


walk_plan = read_plan(plan); % read walking plan from file
p_x = slx;
p_y = sly;
p_x_d = walk_plan.p_x;
p_y_d = walk_plan.p_y;
stance = walk_plan.stance_type;
step_dur = st;
time(1) = step_dur(1);
for i = 2:1:length(step_dur)
    time(i) = time(i-1) + step_dur(i);
end

duration = sum(step_dur);
dt = duration/N;

v_av = p_x(end)/duration; % average velocity


score = 0; % initialize score

step = 1;
for i = 1:N-1
    if dt*i > time(step)
        step = step+1;
    end
    xd = (x(i+1+1)-x(i))/(2*dt); % COM velocity in x
    yd = (y(i+1+1)-y(i))/(2*dt); % COM velocity in y
    score = score + (x(i) - p_x(step))^2 + xd^2 + 30*u_x(i)^2 + (y(i) - p_y(step))^2 + yd^2 + 30*u_y(i)^2;
    score = score + 5*(v_av-xd)^2;
end
avstep_vec = ones(1,length(step_dur))*mean(step_dur)-step_dur;
score = score + 1*N*(avstep_vec*avstep_vec');

for i = 1:1:length(slx)
    score = score + 0.5*N*(p_x(i) - p_x_d(i))^2;
    score = score + 0.5*N*(p_y(i) - p_y_d(i))^2;
end