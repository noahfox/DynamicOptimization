% optimize 1 link swingup trajectory
% optimize using x[k] as variables, represented with samples

% globals
global N; % (N+1) = number of samples.
global duration; % total duration of movement
global goal

% initialize globals
N = 100;
duration = 5.0;
goal = pi;

% p0 is the intitial parameter vector
% it has variable pos[k] as elements
% (leaving off x[1], x[2], x[N], x[N+1]).
i=0:N;
xx0=goal*i/N;
xx0(1) = 0;
xx0(2) = 0;
xx0(N) = goal;
xx0(N+1) = goal;
p0 = xx0(3:N);

% set options for fmincon()
options = optimset('MaxFunEvals',1000000,'MaxIter',1000000);

% do unconstrained optimization
[answer,fval,exitflag]=fminunc(@criterion,p0,options);

% set options for fmincon()
%options = optimset('MaxFunEvals',1000000,'MaxIter',1000000,'Algorithm','sqp');
%options = optimset('MaxFunEvals',1000000,'MaxIter',1000000,'Algorithm','interior-point');

% do constrained optimization
% [answer,fval,exitflag]=fmincon(@criterion,p0,[],[],[],[],[],[],@constraints,options);

fval
exitflag

% restore full trajectory by adding endpoints
xx = 1:N+1;
xx(1) = 0;
xx(2) = 0;
xx(N) = goal;
xx(N+1) = goal;
for i = 3:N-1
 xx(i) = answer(i-2); % copy new array
end;

plot(1:N+1,xx(1:N+1),'b')
