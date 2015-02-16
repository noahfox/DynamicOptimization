function [score] = opti_criterion(joint_angles,robot)
global h w p_d o_d COM_D joint_angle_goals

[ Robut_New,COM_X,COM_Y ] = Robut_Maker(robot,joint_angles);

% UPDATE GRAPHICS
figure(h)
draw(Robut_New,p_d,COM_X,COM_Y);

p = Robut_New.j(29).position_w;
o = Robut_New.l(29).orientation;
  
score = w(1)*(p - p_d)*(p - p_d)' + w(2)*(COM_X-COM_D(1))^2+ w(2)*(COM_Y-COM_D(2))^2 + w(3)*(joint_angles - joint_angle_goals)*(joint_angles - joint_angle_goals)' +...
    w(4)*((((o(:,1)-o_d(:,1))')*(o(:,1)-o_d(:,1))) + (((o(:,2)-o_d(:,2))')*(o(:,2)-o_d(:,2))) + (((o(:,3)-o_d(:,3))')*(o(:,3)-o_d(:,3))));
end