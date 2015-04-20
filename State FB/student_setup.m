% Function to setup and perform any one-time computations
% Input parameters
%   x - state of the rocket, x=[y,z,th,psi,dy,dz,dth,dpsi,m]^T
%   consts - structure that contains various system constants
% Output parameters
%   ctrl  -  any student defined control parameters
function ctrl = student_setup(x0, consts)
% Replace line below with one time computation if needed.
% Ex: ctrl.K = lqr(A, B, Q, R) ;
%{
syms F real ;
f_vec = [   dy
               dz
              dth
             dpsi
                0
               -consts.g
                0
                0
                0] ;
            
    g_vec = [0,    0 ;
             0,    0 ;
             0,    0 ;
             0,    0 ;
            -consts.gamma*sin(psi+th)/m,    0 ;
             consts.gamma*cos(psi+th)/m,    0 ;
             -consts.L*consts.gamma*sin(psi)/consts.J,    0 ;
             0, 1/consts.JT ;
            -1,    0] ;

A = subs(jacobian(f_vec + g_vec*F, x), x, zeros(4,1)) ;
B = subs(jacobian(f_vec + g_vec*F, F), x, zeros(4,1)) ;
ctrl = 0;
%}
end