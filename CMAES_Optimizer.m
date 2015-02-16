clf
clc
clear all
close all

% CMAES Optimizer

% INITIALIZE GLOBAL VARIABLES
global p_d joint_angle_goals COM_D foot_pos robot

% LOAD ROBOT
drc4

% SET ROOT VARIABLES
robot.j(1).position_w = [ 0 0 0.92712 ];
robot.l(1).orientation = q_to_R( [ 0 0 0 1 ] );

% DESIRED RIGHT WRIST POSITION & ORIENTATION
p_d = [0.5 0.3 1];
% o_d = [];
% for i = 1:1:29
%     xmean(i) = robot.j(i).angle;
% end
% xmean
% DRAW ROBOT
% figure(3)
% [ robot,COM_X,COM_Y ] = Robut_Maker( robot,xmean);
% draw(robot,p_d,COM_X,COM_Y);

% SET UP CONSTRAINTS
for i = 2:1:29
    lb(i-1) = robot.j(i).angle_limits(1)-.01;
    ub(i-1) = robot.j(i).angle_limits(2)+.01;
end
foot_pos = [robot.j(10).position_w;
            robot.j(16).position_w];
        
joint_angle_goals = (lb+ub)./2;

COM_D = [0 0];

% Initial guess and search size
x0 = zeros(28,1);

sigma = .5;
%sigma = sigma/sqrt(3);

opts = cmaes;
opts.MaxFunEvals  = 5000;
opts.StopFitness = 1e-2;
opts.LBounds = lb';
opts.UBounds = ub';
opts.CMA.active = 2;
OPTS.Noise.on = 0;
opts.Restarts = 2;
opts.StopOnStagnation = 'on';
opts.TolX = 1e-4;
% Run the optimizer
w = [100; 1000; 10; 1; 1; 1;];
[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('opti_criterion',x0,sigma,opts,w)
