clear all; close all; clc

% OPTIMIZATION CONDITIONS
p_d = [rand(1)-0.5, rand(1)-0.5, rand(1)/2 + 0.5];
% p_d = [.5 -0.4 1.2]; % DESIRED POSITION
o_d = q_to_R([1 .2 .1 0]); % DESIRED ORIENTATION

N = 1; % NUMBER OF TRIALS

% SCORE FUNCTION WEIGHTS
w = [25; 6; 4; 2];
% w = [1; 1; 1; 1];

% RUN OPTIMIZER
for i = 1:1:N
    % SET INITIAL CONDITIONS
    if mod(i,100) == 0
        p_d = rand(1,3)-0.5;
    end
    con_opts = [1];
    x0 = rand(1,29)*pi/2; % STARTING ANGLES
    x0(7:9) = 0; % FIX LEFT LEG AT START
    x0(13:15) = 0; % FIX RIGHT LEG AT START
    [x,score,flag,h] = optimizer(x0,w,p_d,o_d,con_opts);
    fig_name = sprintf('./Results/Run %i.fig',i);
    data_name = sprintf('./Results/Run %i',i);
    %     saveas(h,fig_name);
    %     save(data_name);
    if flag == -2
        con_opts = [0];
        w = [50; 4; 2; 1];
        [x,score,flag,h] = optimizer(x0,w,p_d,o_d,con_opts);
        fig_name = sprintf('./Results/Run %i.fig',i);
        data_name = sprintf('./Results/Run %i',i);
    end
    %     close all;
end