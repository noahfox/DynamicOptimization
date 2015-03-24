function params = write_params(i,P)
p_x = P.p_x{i};
p_y = P.p_y{i};
u_x = P.u_x{i};
u_y = P.u_y{i};
G = 9.81; % gravity (m/s^2)
z = 1; % who knows? (m)

params.p_x = p_x;
params.p_y = p_y;
params.u_x = u_x;
params.u_y = u_y;
params.G = G;
params.z = z;
params.i = i;