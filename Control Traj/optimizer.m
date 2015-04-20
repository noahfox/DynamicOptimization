function optimizer()
clear; close all; clc

opts.MaxFunEvals  = 50000;
opts.TolX = 1e-3;
opts.StopFitness = 1e-2;
opts.CMA.active = 1;
opts.Restarts = 5;
opts.LogPlot = 'on';
opts.LBounds = 0;
opts = cmaes('defaults', opts);

sigma = 1;
n = 50;

u1 = zeros(1,n);
u2 = zeros(1,n);
% u1 = rand(1,n);
% u2 = rand(1,n);
x0 = [u1 u2]';

[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('costfun',x0,sigma,opts);
