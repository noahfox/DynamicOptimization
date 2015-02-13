function [ineq_violations,eq_violations] = constraint_fun(joint_angles,robut_old,p_d,foot_pos)

[robut,COM_X,COM_Y ] = Robut_Maker(robut_old,joint_angles);

% GET AS CLOSE AS POSSIBLE TO TARGET
eq_violations(1) = foot_pos(1,1) - robut.j(10).position_w(1);
eq_violations(2) = foot_pos(1,2) - robut.j(10).position_w(2);
eq_violations(3) = foot_pos(1,3) - robut.j(10).position_w(3);
eq_violations(4) = foot_pos(2,1) - robut.j(16).position_w(1);
eq_violations(5) = foot_pos(2,2) - robut.j(16).position_w(2);
eq_violations(6) = foot_pos(2,3) - robut.j(16).position_w(3);

% eq_violations() = pos(1) - p_d(1);
% eq_violations() = pos(2) - p_d(2);
% eq_violations() = pos(2) - p_d(3);



% STAY UP
ineq_violations = [COM_X-(0.302/2), COM_Y-(0.262/2)];

end