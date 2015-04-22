function statefb_opt()
clear *; close all; clc

global best_yet initials
best_yet = 0;
consts = get_consts();
% States: x=[y,z,th,psi,dy,dz,dth,dpsi,m]'
fuel = consts.m_nofuel+0.7*consts.max.m_fuel;
% initials = [10 150 0 0 0 0 0 0 fuel;
%     -20 150 0 0 0 0 0 0 fuel;
%     30 150 .2 0 0 0 0 0 fuel;
%     -60 150 0 0 0 0 0 0 fuel;
%     30 150 .7 0 0 0 0 0 fuel;
%     20 150 .5 0 10 0 0 0 fuel;
%     30 150 .5 0 0 0 .3 0 fuel;
%     20 150 .2 0 5 0 .1 0 fuel;
%     50 150 .3 0 4 0 .1 0 fuel;
%     -30 150 .5 0 4 0 .2 0 fuel];

initials = [10 150 0 0 0 0 0 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            20 150 0 0 0 0 0 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            -20 150 0 0 0 0 0 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            10 150 .25 0 0 0 0 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            10 150 .5 0 0 0 0 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            10 150 0 0 3 3 0 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            10 150 0 0 10 0 0 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            10 150 0 0 0 0 2 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            10 600 0 0 0 0 0 0 consts.m_nofuel+0.7*consts.max.m_fuel;
            10 500 0 0 10 0 0 0 consts.m_nofuel+0.7*consts.max.m_fuel];


opts.MaxFunEvals  = 50000;
opts.TolX = 1e-2;
opts.StopFitness = 1e-4;
opts.CMA.active = 1;
opts.Restarts = 0;
opts.LogPlot = 'off';
opts.StopOnStagnation = 'on';
opts = cmaes('defaults', opts);

sigma = .2;

% x0 = lqrmaker();
load('../Robust/best_K.mat')
x0 =  K;
x0 = reshape(x0,18,1);

[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('robustcost',x0,sigma,opts); % costfun or robustcost