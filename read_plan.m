function Plan = read_plan(num)
global N

file_name = sprintf('plan%d.txt',num);
fid = fopen(file_name);
vals = textscan(fid,'%f %f %f %f');
Plan.duration = vals{:,1};
Plan.p_x = vals{:,2};
Plan.p_y = vals{:,3};
Plan.stance_type = vals{:,4};

for i = 1:1:length(Plan.duration)
Plan.time(1,i) = sum(Plan.duration(1:i));
end

dt = Plan.time(end)/N;
step_num = 1;
for i = 0:1:N-1
    if dt*i > Plan.time(step_num)
        step_num = step_num+1;
    end
    Plan.p_traj_x(i+1) = Plan.p_x(step_num);
    Plan.p_traj_y(i+1) = Plan.p_y(step_num);
end

fclose(fid);