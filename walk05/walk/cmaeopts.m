clf
clc
clear
close all
format short


% x0 = [.89, -0.047, 0.33, -0.37, -0.10, -0.43, 0.29, 0.26,...
%               -0.080, 0.11, -0.14, -0.22, -0.031, 0.28, 0.085, 0.41,...
%               -0.38, -0.046, -0.29, -0.36, -0.12];

% new starting point
x0 = [0.87484, 0.0029926, 0.24857, -0.34315, -0.076318,...
	 -0.43376, 0.25044, 0.26421, -0.07468, 0.095222,...
	 -0.11934, -0.19511, -0.027485, 0.2729, 0.08126,...
	  0.41064, -0.36543, -0.025123, -0.2804, -0.38862, -0.1108];

sigma = .005;

%line 2439

opts = cmaes;
opts.MaxFunEvals  = 50000;
opts.StopFitness = 500;
opts.CMA.active = 1; %2
OPTS.Noise.on = 0; %0
opts.Restarts = 0;
opts.TolX = 1e-4;
opts.DiagonalOnly = 1; % might make it faster

% Run the optimizer
[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('scoreme',x0,sigma,opts);
