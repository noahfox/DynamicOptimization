clear all; close all; clc
drc4
robot.j(1).position_w = [ 0 0 0.92712 ];
robot.l(1).orientation = q_to_R( [ 0 0 0 1 ] );
h = figure();
% draw(robot,[1,1,1]);
hold on
% MAKE A CHANGE HERE

%
[robot, com_total, total_mass] = drc_forward_kinematics(robot);
% g = figure();
draw(robot,[rand(1)-0.5, rand(1)-0.5, rand(1)/2 + 0.5],com_total(1),com_total(2));
robot.j(a).rotation