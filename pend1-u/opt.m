%%% optimize using u[k] as variables
function [ansarray,fval,exitflag,output]=opt(N,options,u0)

%% param section: constants
%N = 100;
time = 5;
dt = time/N;
length = 1.0;
width = 0.1;
mass = 1.0;
gravity = 9.81;
moment_of_inertia_joint = mass*(length*length + width*width)/12 + mass*length*length/4;
vmin = -10.0;
vmax = 10.0;
umin = -10.0;
umax = 10.0;
goal = pi;
state_penalty = 0.1;

% xx vectors have all points, point 1 is at start, point N is at goal
% xx(1) = xx(2) = 0 due to constraints (including zero velocity at start)
% xx(N) = xx(N-1) = goal due to constraints (including zero velocity at end)
% vv(k) is the velocity to go from x(k) to x(k+1).
% vv(1) = 0
% vv(N) = 0 (and is not used)
% u(K) is command to go from x(k) to x(k+1)
% u(N) is not used.

% u0 is the intitial parameter vector NOW AN ARGUMENT TO opt() above
% u0 = zeros(1,N-1);

[ansarray,fval,exitflag,output]=fminunc(@J,u0,options)

% minimize criterion:
% sum {i in 1..N-1} (state_penalty*(x[i]-goal)*(x[i]-goal) + u[i]*u[i])*dt;
% this cost function computes the optimization criterion
function resJ=J(u)
    resJ=0;
% set up xx, vv, and aa arrays
    xx = 1:N;
    vv = 1:N;
    aa = 1:N;
    xx(1) = 0;
    vv(1) = 0;
    for i = 1:N-1
        aa(i) = (u(i) - mass*gravity*length*0.5*sin(xx(i)))/moment_of_inertia_joint;
        vv(i+1) = vv(i) + aa(i)*dt;
        xx(i+1) = xx(i) + 0.5*(vv(i) + vv(i+1))*dt;
    end;
%				     plot(u)
%                                     pause
				     plot(xx)
drawnow
%                                     pause
%				     plot(xx)
%                                     pause
% Compute state penalties
    for i=1:N
     resJ=resJ + state_penalty*(xx(i)-goal)*(xx(i)-goal)*dt;
    end
% Compute action penalties
    for i=1:N-1 %
     resJ=resJ + u(i)*u(i)*dt;
    end
%    resJ
end
%
%
%
end
