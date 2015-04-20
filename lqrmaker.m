function K = lqrmaker()
consts = get_consts();
c = get_consts();

syms x1 x2 x3 x4 x5 x6 x7 x8 x9 ft T real
f_x = [ x5;
        x6;
        x7;
        x8;
        0;
        -x9*c.g;
        0;
        0;
        0];
g_x = [ 0 0;
        0 0;
        0 0;
        0 0;
        -c.gamma/x9*sin(x3+x4) 0;
        c.gamma/x9*cos(x3 + x4) 0;
        -c.L*c.gamma/c.J*sin(x4) 0;
        0 1/c.JT;
        -1 0];
x = [x1 x2 x3 x4 x5 x6 x7 x8 x9];
% syms ft T y z th ps dy dz dth dpsi m real
u = [ft; T];
%  f_x = [   dy
%                dz
%               dth
%              dpsi
%                 0
%                -consts.g
%                 0
%                 0
%                 0] ;
%             
%     g_x = [0,    0 ;
%              0,    0 ;
%              0,    0 ;
%              0,    0 ;
%             -consts.gamma*sin(ps+th)/m,    0 ;
%              consts.gamma*cos(ps+th)/m,    0 ;
%              -consts.L*consts.gamma*sin(ps)/consts.J,    0 ;
%              0, 1/consts.JT ;
%             -1,    0] ;

target = [0 c.L 0 0 0 0 0 0 c.max.m_fuel];
% x = [y z th ps dy dz dth dpsi m];
A = subs(jacobian(f_x,x),x,target);
% B = subs(jacobian(f_x + g_x*u,u),x,target);
B = [   0 0;
        0 0;
        0 0;
        0 0;
        -2*c.gamma/c.max.m_fuel 0;
        c.gamma/c.max.m_fuel^2 0;
        2*c.L*c.gamma/c.J 0;
        0 1/c.JT;
        -1 0]
            
A = eval(A)
%B = eval(B)
% C = eye(9);
% D = zeros(9,2);     

% Control = ctrb(A,B);
% rank(Control)
% [A,B] = minreal(A,B,C,D)

Q = eye(9);
R = eye(2);


K = lqr(A,B,Q,R);


end

