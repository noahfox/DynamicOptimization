function score = costfun(K)
[J x] = sim_rocket(K);
score = 100 - J;
if any(abs(x(:,3))) > pi/2 || any(abs(x(:,4))) > pi/2
    score = inf;
end