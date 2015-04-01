function [ineq_violations,eq_violations] = constraint_fun(p)
global N

walk_plan = read_plan(1); % read walking plan from file
P_x = walk_plan.p_x;
P_y = walk_plan.p_y;
stance = walk_plan.stance_type;
step_dur = walk_plan.duration;


duration = sum(step_dur);
dt = duration/N;
z = 1; % set height to constant
gravity = 9.81;

idx = 1;
% dynamics
for i = 1:N-1
    ddx = (a0(i+1+1)-2*a0(i+1)+a0(i-1+1))/(dt^2);
    tce(idx) = acc_x - (x - p_x + u_x) * G/z;
    idx = idx + 1;
end


% STUFF FROM LAST TIME FOR REFERENCE

%function [ineq_violations,eq_violations] = constraint_fun(joint_angles,robut_old)
% global con_opts foot_pos p_d l_foot_ori r_foot_ori
% % joint_angles
% [robut,COM_X,COM_Y ] = Robut_Maker(robut_old,joint_angles);
%
% % FOOT POSITION
% eq_violations(1) = foot_pos(1,1) - robut.j(11).position_w(1);
% eq_violations(2) = foot_pos(1,2) - robut.j(11).position_w(2);
% eq_violations(3) = foot_pos(1,3) - robut.j(11).position_w(3);
% eq_violations(4) = foot_pos(2,1) - robut.j(17).position_w(1);
% eq_violations(5) = foot_pos(2,2) - robut.j(17).position_w(2);
% eq_violations(6) = foot_pos(2,3) - robut.j(17).position_w(3);
%
% % FOOT ORIENTATION
% eq_violations(7) = norm(l_foot_ori - robut.j(11).rotation,2);
% eq_violations(8) = norm(r_foot_ori - robut.j(17).rotation,2);
%
% % MUST GET TO TARGET
% if con_opts(1) ~= 0
%     eq_violations(9) = robut.j(29).position_w(1) - p_d(1);
%     eq_violations(10) = robut.j(29).position_w(2) - p_d(2);
%     eq_violations(11) = robut.j(29).position_w(3) - p_d(3);
% end
%
% % STAY UP
% ineq_violations = [abs(COM_X)-(0.302/2), abs(COM_Y)-(0.262/2)];