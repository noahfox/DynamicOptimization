function [xd, yd] = datderiv(x,y,dt)
global N

% differentiate COM x and Y positions
for i = 1:N-2
    xd(i) = (x(i+2)-x(i))/(2*dt); % COM velocity in x
    yd(i) = (y(i+2)-y(i))/(2*dt); % COM velocity in x
end

end