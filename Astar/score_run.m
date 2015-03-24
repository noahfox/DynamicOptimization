function score = score_run(c,P)

n = length(P.duration);
score = 0; % initialize

p_x = P.p_x(i);
p_y = P.p_y(i);


x = c(1:n);
y = c(n+1:2*n);
u_x = c(2*n+1:3*n);
u_y = c(3*n+1:4*n);

for i = 1:1:n
    score = score + cost_fun(x(i),p_x(i),xd(i),u_x(i),y(i),p_y(i),yd(i),u_y(i));
end