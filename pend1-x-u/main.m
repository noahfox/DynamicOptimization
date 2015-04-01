% optimize 1 link swingup trajectory
% optimize using both x[k] and u[k] as variables

global N;
N = 100;
% set options for fmincon()
options = optimset('MaxFunEvals',1000000);

% p0 is the intitial parameter vector
goal = pi;
i=0:N;
a0=goal*i/N;
p0=[a0 zeros(1,N)]; % a0 u0

% do optimization
[answer,fval,exitflag]=fmincon(@criterion,p0,[],[],[],[],[],[],@constraints,options);

fval
exitflag

plot(1:N+1,answer(1:N+1),'r',1:N,answer(N+2:2*N+1),'b')
