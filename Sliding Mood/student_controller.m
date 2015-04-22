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
    s = sum(ctrl.surf .* x);
    y = x(1) ;
    z = x(2) ;
    th = x(3) ; 
    psi = x(4) ;
        %%%
    dy = x(5) ;
    dz = x(6) ;
    dth = x(7) ;
    dpsi = x(8) ;
        %%%
    m = x(9) ;
    
    f_vec = [   dy
               dz
              dth
             dpsi
                0
               -consts.g
                0
                0
                0]; 
            
    g_vec = [0,    0 ;
             0,    0 ;
             0,    0 ;
             0,    0 ;
            -consts.gamma*sin(psi+th)/m,    0 ;
             consts.gamma*cos(psi+th)/m,    0 ;
             -consts.L*consts.gamma*sin(psi)/consts.J,    0 ;
             0, 1/consts.JT ;
            -1,    0] ;
    af = sum(ctrl.surf.*f_vec);
    ag1 = sum(ctrl.surf.*g_vec(:,1));
    ag2 = sum(ctrl.surf.*g_vec(:,2));
    u(1) = -(af/ag1+ctrl.beta0)*sign(s);
    u(2) = -(af/ag2+ctrl.beta0)*sign(s);
    u = u';
    
end