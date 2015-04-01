%%% constraints for optimizing using both x[k] and u[k] as variables
function [ineq_violations,eq_violations]=constraints(p)

global N

%% param section: constants
duration = 5.0;
dt = duration/N;
length = 1.0;
width = 0.1;
mass = 1.0;
z = 1; % set height to constant
moment_of_inertia_joint = mass*(length*length + width*width)/12 + mass*length*length/4;
gravity = 9.81;
goal = pi;

% we show how to apply constraints on velocity below.
vmin = -10.0;
vmax = 10.0;
% you can apply constraints on position, acceleration, and u[k] as well.

%% implement constraints in this function
% s.t. dynamics: u[] = xxx
% s.t. x_init: x[0] = 0;
% s.t. x_final: x[N] = goal;
% s.t. v_init: v_offset[0] = 0;
% s.t. v_final: v_offset[N-1] = 0;
% s.t. v_max {i in 1..N-1}: v[i] <= vmax;tce(idx)=a0(1);
%s.t. x_final
% s.t. v_min {i in 1..N-1}: v[i] >= vmin;

i_a0 = 1;
i_u0 = i_a0 + N + 1;

a0=p(i_a0:i_a0+N);
u0=p(i_u0:i_u0+N-1);

%s.t. newton
idx=0;
for i=1:N-1
%  v0 = (a0(i+1+1)-a0(i-1+1))/(2*dt);
 acc0 = (a0(i+1+1)-2*a0(i+1)+a0(i-1+1))/(dt^2);
 idx=idx+1;
 tce(idx)= u0(i) - mass*gravity*length*0.5*sin(a0(i+1))-moment_of_inertia_joint*acc0;
end
%s.t. x_init
idx=idx+1;

% set final angle equal to goal
idx=idx+1;
tce(idx)=a0(N+1)-goal;
%s.t. v_init
% v0 = 0
idx=idx+1;
tce(idx)=a0(2)-a0(1);
%s.t. v_final:
% v_final = 0
idx=idx+1;
tce(idx)=a0(N+1)-a0(N);

% max/min velocities
%s.t. v_max    
idx=0;
for i=1:N-1
 idx=idx+1;
 tc(idx)=(a0(i+1+1)-a0(i-1+1))/(2*dt)-vmax;
end
%s.t v_min    
for i=1:N-1
 idx=idx+1;
 tc(idx)=-(a0(i+1+1)-a0(i-1+1))/(2*dt)+vmin;
end

eq_violations=tce';
ineq_violations=tc';

end
%% final end

%{

ddx = (a0(i+1+1)-2*a0(i+1)+a0(i-1+1))/(dt^2)
tce(idx) = acc_x - (x - p_x + u_x) * G/z;


%}