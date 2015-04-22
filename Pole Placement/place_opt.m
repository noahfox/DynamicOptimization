function place_opt()
clear *; close all; clc

global best_yet
best_yet = 0;

opts.MaxFunEvals  = 50000;
opts.TolX = 1e-2;
opts.StopFitness = 1e-4;
opts.CMA.active = 1;
opts.Restarts = 0;
opts.LogPlot = 'off';
opts.StopOnStagnation = 'on';
opts = cmaes('defaults', opts);

sigma = 2;

x0 = [-1,1,-2,-3,-4,-5,-6,-7,-8,-9];

[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('costfun',x0,sigma,opts);