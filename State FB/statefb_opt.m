function statefb_opt()
clear *; close all; clc
use_cmaes = 1;

if use_cmaes
    opts.MaxFunEvals  = 50000;
    opts.TolX = 1e-3;
    opts.StopFitness = 1e-2;
    opts.CMA.active = 1;
    opts.Restarts = 5;
    opts.LogPlot = 'on';
    opts = cmaes('defaults', opts);
    
    sigma = .1;
 
    x0 = rand(18,1)*10;
    % x0 = zeros(18,1);
    
    [XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('costfun',x0,sigma,opts);
    
else
    options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3);
    
    
    p0 = rand(18,1)*.1;
    % p0 = zeros(18,1);
    
    [K,fval,exitflag]=fmincon(@costfun,p0,[],[],[],[],[],[],@constraintfun,options);
    fval
    exitflag
end