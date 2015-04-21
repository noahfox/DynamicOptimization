function statefb_opt()
clear *; close all; clc

global best_yet
best_yet = 0;

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
    
    x0 = lqrmaker();
    x0 = reshape(x0,18,1);
    
    [XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('costfun',x0,sigma,opts);
    
else
    options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3);
    
    
    p0 = lqrmaker();
    p0 = reshape(p0,18,1);
    
    [K,fval,exitflag]=fmincon(@costfun,p0,[],[],[],[],[],[],@constraintfun,options);
    fval
    exitflag
end