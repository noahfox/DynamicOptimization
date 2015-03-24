






function [x,y] = dynamics(params)
xdd = (x - p_x + u_x) * G/z;
ydd = (y - p_y + u_y) * G/z;