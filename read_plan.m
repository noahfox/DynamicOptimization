function Plan = read_plan(num)
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