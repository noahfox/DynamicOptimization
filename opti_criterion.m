function [score] = opti_criterion(joint_angles,robot,p_d,foot_pos)

% [robot,robot_com,~] = drc_forward_kinematics(new_robot);

% UPDATE GRAPHICS
draw3(robot);

p = robot.j(29).position_w;

score = (p - p_d)'*(p - p_d);

end