function statefb_opt()
clear *; close all; clc

global best_yet initials runs
best_yet = 0;
consts = get_consts();

% States: x=[y,z,th,psi,dy,dz,dth,dpsi,m]'
fuel = consts.m_nofuel+0.7*consts.max.m_fuel;
initials = [10 150 0 0 0 0 0 0 fuel;
           -20 150 0 0 0 0 0 0 fuel;
            30 150 .2 0 0 0 0 0 fuel;
           -60 150 0 0 0 0 0 0 fuel;
            30 150 .7 0 0 0 0 0 fuel;
            20 150 .5 0 10 0 0 0 fuel;
            30 150 .5 0 0 0 .3 0 fuel;
            20 150 .2 0 5 0 .1 0 fuel;
            50 150 .3 0 4 0 .1 0 fuel;
           -30 150 .5 0 4 0 .2 0 fuel];

% runs = 30;
            
use_cmaes = 1;

if use_cmaes
    opts.MaxFunEvals  = 50000;
    opts.TolX = 1e-2;
    opts.StopFitness = 1e-4;
    opts.CMA.active = 1;
    opts.Restarts = 0;
    opts.LogPlot = 'off';
    opts.StopOnStagnation = 'on';
    opts = cmaes('defaults', opts);
    
    sigma = .1;
    
%     x0 = lqrmaker();
%     x0 = reshape(x0,18,1);
    x0 = [1 1 1 1 10 10 10 10 1 .01 .1]; 
    
    [XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('robustqr',x0,sigma,opts);
    
else
    options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3);
    
    
    p0 = lqrmaker();
    p0 = reshape(p0,18,1);
    
    [K,fval,exitflag]=fmincon(@costfun,p0,[],[],[],[],[],[],@constraintfun,options);
    fval
    exitflag
end