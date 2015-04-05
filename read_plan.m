function Plan = read_plan(num)
global N

% ----------------------------------------------------------------------- %
% READ FILE
% ----------------------------------------------------------------------- %
file_name = sprintf('plan%d.txt',num);
fid = fopen(file_name);
vals = textscan(fid,'%f %f %f %f'); % values from param file

% ----------------------------------------------------------------------- %
% PROCESS VALUES INTO STRUCTURE
% ----------------------------------------------------------------------- %
Plan.duration = vals{:,1}; % step durations
Plan.p_x = vals{:,2}; % x foot locations
Plan.p_y = vals{:,3}; % y foot locations
Plan.stance_type = vals{:,4}; % stance type

for i = 1:1:length(Plan.duration)
Plan.time(1,i) = sum(Plan.duration(1:i)); % time of each step
end

dt = Plan.time(end)/N; % time step

% foot locations at each sim step
step_num = 1;
for i = 0:1:N-1
    if dt*i > Plan.time(step_num)
        step_num = step_num+1;
    end
    Plan.p_traj_x(i+1) = Plan.p_x(step_num);
    Plan.p_traj_y(i+1) = Plan.p_y(step_num);
end

fclose(fid);