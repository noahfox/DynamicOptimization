clear all; close all; clc

% OPTIMIZATION CONDITIONS
% p_d = [rand(1)-0.5, rand(1)-0.5, rand(1)/2 + 0.5];
p_d = [0.0891, 0.1742, 0.7940];
% p_d = [-0.5 -0.2 1]; % DESIRED POSITION (L, R, V)
o_d = q_to_R([1 .2 0 0]); % DESIRED ORIENTATION

N = 50; % NUMBER OF TRIALS
e = 0.2; % REQUIRED DIFFERENCE

% SCORE FUNCTION WEIGHTS
w = [25; 6; 4; 2];

% RUN OPTIMIZER
for i = 1:1:N
    con_opts = [1];
    x0 = randn(1,29)/2; % STARTING ANGLES
    x0(7:9) = 0; % FIX LEFT LEG AT START
    x0(13:15) = 0; % FIX RIGHT LEG AT START
    [x,score,flag,h] = optimizer(x0,w,p_d,o_d,con_opts);
    if flag == -2
        con_opts = [0];
        w = [50; 4; 2; 1];
        [x,score,flag,h] = optimizer(x0,w,p_d,o_d,con_opts);
    end
    is_new = 1;
    
    if i ~=1
        for j = 1:1:length(minima)
            if abs(sum(x) - sum(minima{j})) < e
                is_new = 0;
            end
        end
    end
    
    if is_new == 1
        fig_name = sprintf('./Results/Local Minimum %i.fig',i);
        data_name = sprintf('./Results/Local Minimum %i',i);
        saveas(h,fig_name);
        save(data_name);
        minima{i} = x;
    end
    close all;
end