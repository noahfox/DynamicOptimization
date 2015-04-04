function [xd, yd] = datderiv(x,y,dt)
global N

for i = 1:N-2
    xd(i) = (x(i+1+1)-x(i))/(2*dt); % COM velocity in x
    yd(i) = (y(i+1+1)-y(i))/(2*dt); % COM velocity in x
end

end