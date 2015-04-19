function optimizer()
clear; close all; clc

opts.MaxFunEvals  = 50000;
opts.TolX = 1e-3;
opts.StopFitness = 1e-2;
opts.CMA.active = 1;
opts.Restarts = 3;
opts.LogPlot = 'on';
opts = cmaes('defaults', opts);

sigma = 0.2;
n = 20;

u1 = zeros(1,n);
u2 = zeros(1,n);
x0 = [u1 u2]';

[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('costfun',x0,sigma,opts);
