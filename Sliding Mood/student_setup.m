% Function to setup and perform any one-time computations
% Input parameters
%   x - state of the rocket, x=[y,z,th,psi,dy,dz,dth,dpsi,m]^T
%   consts - structure that contains various system constants
% Output parameters
%   ctrl  -  any student defined control parameters
function ctrl = student_setup(x0, consts)
    % Replace line below with one time computation if needed.
    % Ex: ctrl.K = lqr(A, B, Q, R) ;
    ctrl.surf = [ 1.9 1.8 1.7 1.6 1 1.4 1.3 1.2 1.1]';
    ctrl.beta0 = .1;
end