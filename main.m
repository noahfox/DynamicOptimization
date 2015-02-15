clear all; close all; clc

% OPTIMIZATION CONDITIONS
% p_d = [.4 -0.4 1.2]; % DESIRED POSITION
p_d = rand(1,3)-0.5;
N = 100; % NUMBER OF TRIALS

for i = 1:1:N
    % SET INITIAL CONDITIONS
    if mod(i,100) == 0
        p_d = rand(1,3)-0.5;
    end
    con_opts = [1];
    x0 = rand(1,29)*pi/2; % STARTING ANGLES
    [x,score,flag,h] = optimizer(x0,p_d,con_opts);
    fig_name = sprintf('./Results/Run %i.fig',i);
    data_name = sprintf('./Results/Run %i',i);
    saveas(h,fig_name);
    save(data_name);
    if flag == -2
        con_opts = [0];
        [x,score,flag,h] = optimizer(x0,p_d,con_opts);
        fig_name = sprintf('./Results/Run %i.fig',i);
        data_name = sprintf('./Results/Run %i',i);
    end
    close all;
end