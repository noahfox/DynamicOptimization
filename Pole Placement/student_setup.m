% Function to setup and perform any one-time computations
% Input parameters
%   x - state of the rocket, x=[y,z,th,psi,dy,dz,dth,dpsi,m]^T
%   consts - structure that contains various system constants
% Output parameters
%   ctrl  -  any student defined control parameters
function ctrl = student_setup(x0, consts, e_vals)
% Replace line below with one time computation if needed.
% Ex: ctrl.K = lqr(A, B, Q, R) ;
syms y z th ps dy dz dth dpsi m ft T real

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
        -consts.gamma*sin(ps+th)/m,    0 ;
        consts.gamma*cos(ps+th)/m,    0 ;
        -consts.L*consts.gamma*sin(ps)/consts.J,    0 ;
        0, 1/consts.JT ;
        -1,    0] ;

x = [y z th ps dy dz dth dpsi m];
u = [ft; T];

sys = f_vec + g_vec*u;

% consts.m_nofuel
% consts.max.m_fuel

ft_0 = (consts.max.m_fuel*consts.g)/consts.gamma;

eq = [0 consts.L 0 0 0 0 0 0 consts.max.m_fuel 1.4715 0];
eq_vars = [y z th ps dy dz dth dpsi m ft T];

A_sym = jacobian(sys,x);
B_sym = jacobian(sys,u);

A = eval(subs(A_sym,eq_vars,eq));
B = eval(subs(B_sym,eq_vars,eq));

ctrl.K = place(A,B,e_vals);
end