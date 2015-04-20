function J = sim_rocket(u_vec,x0)
close all ;

% load constant parameters
consts = get_consts() ;

if(nargin < 2)
    x0 = [10; 150; 0; 0;
        0; 0; 0; 0;
        consts.m_nofuel+0.7*consts.max.m_fuel] ;
end


% call student one-time setup
ctrl = student_setup(x0) ;


% Integrate system
odeopts = odeset('Events',@odeevents_touchdown) ;
[t x] = ode45(@odefun_rocket, [0 60], x0, odeopts, consts, ctrl, u_vec) ;


% Display Helpful information after simulation
%     disp(['Touchdown Time: ' num2str(t(end))]) ;
%     disp(['Touchdown Configuration: y=' num2str(x(end,1)) ' z=' num2str(x(end,2)) ' theta(deg)=' num2str(x(end,3)*180/pi) ' psi(deg)=' num2str(x(end,4)*180/pi)]) ;
%     disp(['Touchdown Velocity: y=' num2str(x(end,5)) ' z=' num2str(x(end,6)) ' theta(deg/s)=' num2str(x(end,7)*180/pi) ' psi(deg/s)=' num2str(x(end,8)*180/pi)]) ;

J = compute_score(x(end,:)', consts) ;
disp(['Score: ' num2str(J)]) ;

% Plots
%     figure ; plot(t, x(:,1)) ; grid on ; xlabel('Time (s)') ; ylabel('y (m)') ;
%     figure ; plot(t, x(:,2)) ; grid on ; xlabel('Time (s)') ; ylabel('z (m)') ;
%     figure ; plot(t, x(:,3)*180/pi) ; grid on ; xlabel('Time (s)') ; ylabel('theta (deg)') ;
%     figure ; plot(t, x(:,4)*180/pi) ; grid on ; xlabel('Time (s)') ; ylabel('psi (deg)') ;

% Animation
u = zeros(length(t), 2) ;
for j=1:length(t)
    [dx uu] = odefun_rocket(t, x(j,:)', consts, ctrl, u_vec) ;
    u(j,:) = uu' ;
end
animate_rocket(t, x, u) ;
end


function [dx u] = odefun_rocket(t, x, consts, ctrl, u_vec)
y = x(1) ;
z = x(2) ;
th = x(3) ;
psi = x(4) ;

dy = x(5) ;
dz = x(6) ;
dth = x(7) ;
dpsi = x(8) ;

m = x(9) ;

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

% call student controller
%     u = student_controller(t, x, consts, ctrl) ;
u = u_fun(t, u_vec);
% Check if fuel is over
if(m <= consts.m_nofuel)
    u(1) = 0 ;
end

% Thrust / Torque saturations
u(1) = min(max(u(1), 0), consts.max.fT) ;
u(2) = min(max(u(2), -consts.max.tau), consts.max.tau) ;

dx = f_vec + g_vec*u ;
end

% Exit integration on contact
function [value,isterminal,direction] = odeevents_touchdown(t, x, consts, ctrl, u_vec)
z = x(2) ; th = x(3) ; L = consts.L ; r = consts.r ;
% Make a list of possible contact points
contact_points = [z-L*cos(th)-r*sin(th);
    z-L*cos(th)+r*sin(th);
    z+L*cos(th);
    z-r*sin(th);
    z+r*sin(th)] ;
value = min(contact_points) ;
isterminal = 1;   % Stop the integration
direction = 0;   % all direction only
end

function u = u_fun(t, u_vec)
sim_time = 60; % set manually
n = length(u_vec{1});
t_vec = [0:sim_time/(n-1):sim_time]';

if length(t) > 1
    u(1) = u_vec{1}(end);
    u(2) = u_vec{2}(end);
    u = u';
    return
end
if t < sim_time
    u(1) = interp1(t_vec,u_vec{1},t,'linear');
    u(2) = interp1(t_vec,u_vec{2},t,'linear');
elseif t == sim_time
    u(1) = u_vec{1}(end);
    u(2) = u_vec{2}(end);
end
u = u';
end