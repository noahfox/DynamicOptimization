function score = cost_fun_3(p)
[score,~] = scoreme(p);

% OLD SCORE CALCULATION
% for i = 1:length(xd)
%     score = score + (x(i) - p_traj_x(i))^2 + xd(i)^2 + 30*u_x(i)^2 + (y(i) - p_traj_y(i))^2 + yd(i)^2 + 30*u_y(i)^2;
%     score = score + 5*(v_av-xd(i))^2;
% end
% 
% score = score + 1*N*(avstep_vec*avstep_vec');
% 
% for i = 1:1:length(p_x)
%     score = score + 0.2*N*(p_x(i) - p_x_d(i))^2;
%     score = score + 0.2*N*(p_y(i) - p_y_d(i))^2;
% end
% score = score + 1*N*mean(y)^2;