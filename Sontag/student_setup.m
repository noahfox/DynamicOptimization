% Function to setup and perforx9 anx1 one-tix9e cox9putations
% Input parax9eters
%   x - state of x3e rocket, x=[x1,x2,x3,x4,x5,x6,x7,x8,x9]^T
%   consts - structure x3at contains various sx1stex9 constants
% Output parax9eters
%   ctrl  -  anx1 student defined control parax9eters
function ctrl = student_setup(x0, consts)
qr = [1 1 1 1 1 1 1 1 1 1 1];
[~,P] = lqrmaker(qr);
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 real

f_vec = [   x5
    x6
    x7
    x8
    0
    -consts.g
    0
    0
    0] ;

g_vec = [0,    0 ;
    0,    0 ;
    0,    0 ;
    0,    0 ;
    -consts.gamma*sin(x4+x3)/x9,    0 ;
    consts.gamma*cos(x4+x3)/x9,    0 ;
    -consts.L*consts.gamma*sin(x4)/consts.J,    0 ;
    0, 1/consts.JT ;
    -1,    0] ;

x = [x1 x2 x3 x4 x5 x6 x7 x8 x9]';
V = x'*P*x;
LfV(x1,x2,x3,x4,x5,x6,x7,x8,x9) = jacobian(V,x)*f_vec;
LgV(x1,x2,x3,x4,x5,x6,x7,x8,x9) = jacobian(V,x)*g_vec;
ctrl.LfVfun = matlabFunction(LfV);
ctrl.LgVfun = matlabFunction(LgV);
end