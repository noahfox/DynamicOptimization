function [ineq_violations,eq_violations] = constraint_fun(joint_angles,robot,p_d,foot_pos)


% GET AS CLOSE AS POSSIBLE TO TARGET
eq_violations(1) = foot_pos(1,1) - robot.j(10).position_w(1);
eq_violations(1) = foot_pos(1,2) - robot.j(10).position_w(2);
eq_violations(1) = foot_pos(1,3) - robot.j(10).position_w(3);
eq_violations(1) = foot_pos(2,1) - robot.j(16).position_w(1);
eq_violations(1) = foot_pos(2,2) - robot.j(16).position_w(2);
eq_violations(1) = foot_pos(2,3) - robot.j(16).position_w(3);

% eq_violations() = pos(1) - p_d(1);
% eq_violations() = pos(2) - p_d(2);
% eq_violations() = pos(2) - p_d(3);



% STAY UP
ineq_violations = [robot_com(1)-(0.302/2);
                   robot_com(2)-(0.262/2)];

end