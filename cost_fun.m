function C = cost_fun(x,p_x,xd,u_x,y,p_y,yd,u_y)
C = (x - p_x)^2 + xd^2 + 30*u_x^2 + (y - p_y)^2 + yd^2 + 30*u_y^2;