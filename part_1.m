clear; close all; clc; echo on

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N plan
N = 100;
plan = 1;
rng('shuffle','twister')
options = optimset('MaxFunEvals',1000000,'Algorithm','sqp');




% p0 is the intitial parameter vector
x0 = rand(1,N+1);
y0 = rand(1,N+1);
u_x0 = zeros(1,N+1);
u_y0 = zeros(1,N+1);
p0=[x0 y0 u_x0 u_y0]; % a0 u0


[answer,fval,exitflag]=fmincon(@cost_fun,p0,[],[],[],[],[],[],@constraint_fun,options);

fval
exitflag