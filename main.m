clear all; close all; clc

% OPTIMIZATION CONDITIONS
p_d = [.4 -0.4 1.2]; % DESIRED POSITION
N = 1; % NUMBER OF TRIALS

for i = 1:1:N
% SET INITIAL CONDITIONS
x0 = rand(1,29)*pi; % STARTING ANGLES
[x{i},score{i},h] = optimizer(x0,p_d);
file = sprintf('Run %i.fig',i);
saveas(h,file);
end