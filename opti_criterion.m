function [score] = opti_criterion(joint_angles,robot)
global p_d COM_D joint_angle_goals


[ Robut_New,COM_X,COM_Y ] = Robut_Maker( robot,joint_angles);


% [robot,robot_com,~] = drc_forward_kinematics(new_robot);

% UPDATE GRAPHICS
draw(Robut_New,p_d);

p = Robut_New.j(29).position_w;
w = [1; 1; 1; 1; 1; 1;];
score = w(1)*(p - p_d)*(p - p_d)' + w(2)*(COM_X-COM_D(1))^2+ w(2)*(COM_Y-COM_D(2))^2 + w(3)*(joint_angles - joint_angle_goals)*(joint_angles - joint_angle_goals)';

end