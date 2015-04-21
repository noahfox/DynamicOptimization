function K = lqrmaker(w)
consts = get_consts();
global target
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
u = [ft T];

sys = f_vec + g_vec*u';

target = [0 consts.L 0 0 0 0 0 0 consts.max.m_fuel];

A_sym = jacobian(sys,x);
B_sym = jacobian(sys,u);

A = eval(subs(A_sym,[x u],[target 0 0]))
B = eval(subs(B_sym,[x u],[target 0 0]))

% Control = ctrb(A,B);
% rank(Control)

Q = diag([1 1 1 1 1 1 1 1 1]);
R = diag([.05 .1]);

K = lqr(A,B,Q,R);

end

