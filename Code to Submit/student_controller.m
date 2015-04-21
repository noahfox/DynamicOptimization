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
    K = [-0.0000    1.1544   -0.0000    0.0000    0.0000    8.5728   -0.0000    0.0000   -0.1575
          0.1306    0.0000  -37.6338   72.8933    1.6009    0.0000  -48.6607   30.3236    0.0000];
    u = -K*x;
end