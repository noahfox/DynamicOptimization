function dx = dynamics(x,y,u_x,u_y,P)

% ----------------------------------------------------------------------- %
% PARAMETERS
% ----------------------------------------------------------------------- %
p_x = P.p_x(i);
p_y = P.p_y(i);
G = 9.81; % gravity (m/s^2)
z = 1; % who knows? (m)

u_x = u(i,1);
u_y = u(i,2);

% ----------------------------------------------------------------------- %
% STATE SPACE MODEL
% ----------------------------------------------------------------------- %
% STATES
% x1 = x
% x2 = y
% x3 = dx
% x4 = dy

dx = [          x(3)
                x(4)
    (x(1) - p_x + u_x) * G/z
    (x(2) - p_y + u_y) * G/z];

end