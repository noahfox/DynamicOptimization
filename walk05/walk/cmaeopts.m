clf
clc
clear
close all


x0 = [.89, -0.047, 0.33, -0.37, -0.10, -0.43, 0.29, 0.26,...
              -0.080, 0.11, -0.14, -0.22, -0.031, 0.28, 0.085, 0.41,...
              -0.38, -0.046, -0.29, -0.36, -0.12];

sigma = .3;

%line 2439

opts = cmaes;
opts.MaxFunEvals  = 50000;
opts.StopFitness = 1e-2;
opts.CMA.active = 2;
OPTS.Noise.on = 0;
opts.Restarts = 0;
opts.TolX = 1e-4;
% Run the optimizer
[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('scoreme',x0,sigma,opts)
