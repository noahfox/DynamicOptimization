% Student supplied function to compute the control input at each instant of time
% Input parameters:
%   t  -  Time (in seconds) since start of simulation
%   x - state of the rocket, x=[y,z,th,psi,dy,dz,dth,dpsi,m]^T
%   consts - structure that contains various system constants
%   ctrl  -  any student defined control parameters
% Output parameters:
%   u  -  [thrust; torque] - two inputs to the rocket
function u = student_controller(t, x, consts, ctrl)
    % Replace line below with your controller
    % Ex: u = -ctrl.K*x ;
    K = [ -0.0000    0.1997    0.0000   -0.0000   -0.0000    3.8326    0.0000   -0.0000   -0.0179
    0.3910    0.0000  -69.7857   99.8428    3.3938    0.0000  -80.8793   35.5443    0.0000];
    u = -K*x;
end