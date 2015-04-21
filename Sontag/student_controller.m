% Student supplied function to compute the control input at each instant of time
% Input parameters:
%   t  -  Time (in seconds) since start of simulation
%   x - state of the rocket, x=[y,z,th,psi,dy,dz,dth,dpsi,m]^T
%   consts - structure that contains various system constants
%   ctrl  -  any student defined control parameters
% Output parameters:
%   u  -  [thrust; torque] - two inputs to the rocket
function u = student_controller(t, x, consts, ctrl)
% syms x1 x2 x3 x4 x5 x6 x7 x8 x9 real
% sym_vec = [x1 x2 x3 x4 x5 x6 x7 x8 x9]';

% LfV = eval(subs(ctrl.LfV,sym_vec,x));
% LgV = eval(subs(ctrl.LgV,sym_vec,x));

LfV = ctrl.LfVfun(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9));
LgV = ctrl.LgVfun(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9));

if LgV(1) ~= 0
    u(1) = -(LfV + sqrt(LfV^2 + LgV(1)^4))/LgV(1);
else
    u(1) = 0;
end

if LgV(2) ~= 0
    u(2) = -(LfV + sqrt(LfV^2 + LgV(2)^4))/LgV(2);
else
    u(2) = 0;
end

u = u';
end