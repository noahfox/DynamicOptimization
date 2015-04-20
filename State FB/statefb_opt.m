function statefb_opt()
clear *; close all; clc

options = optimset('MaxFunEvals',1000000,'Algorithm','sqp','Display','iter','TolFun',1e-3);


p0 = rand(18,1)*.1;
% p0 = zeros(18,1);

[K,fval,exitflag]=fmincon(@costfun,p0,[],[],[],[],[],[],@constraintfun,options);
fval
exitflag