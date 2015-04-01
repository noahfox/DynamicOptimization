clear; close all; clc; echo on

% ----------------------------------------------------------------------- %
% SETUP
% ----------------------------------------------------------------------- %
global N
N = 100;
rng('shuffle','twister')
options = optimset('MaxFunEvals',1000000,'Algorithm','sqp');




% p0 is the intitial parameter vector
x0 = rand(1,N+1);
y0 = rand(1,N+1);
u_x0 = zeros(1,N);
u_y0 = zeros(1,N);
p0=[x0 y0 u_x0 u_y0]; % a0 u0


[answer,fval,exitflag]=fmincon(@criterion,p0,[],[],[],[],[],[],@constraints,options);

fval
exitflag

plot(1:N+1,answer(1:N+1),'r',1:N,answer(N+2:2*N+1),'b')