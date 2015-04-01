N=100;
goal = pi;
options = optimset('MaxFunEvals',100*100*N);
% do optimization
load u0
[matlabarray,fval,exitflag,output]=opt(N,options,u0);
xx = 1:N;
xx(1) = 0;
xx(2) = 0;
xx(N-1) = goal;
xx(N) = goal;
for i = 3:N-2
	    xx(i) = matlabarray(i-2); % copy new array
	    end;
% load ampl answer
amplans;
%% plot them both
plot(amplarray(:,2),'r');
hold
plot(xx,'b')
hold off
