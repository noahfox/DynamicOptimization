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
x0 = [ 0.6732
    0.4482
   -0.0946
    0.2713
    0.5232
   -0.0000
   -0.2660
    0.5025
   -0.1499
   -0.0000
   -0.5247
   -0.0000
   -0.2660
    0.5026
   -0.1500
   -0.0001
   -0.3907
   -0.0007
    1.5710
    1.1782
    1.5708
   -0.0000
   -0.8363
    0.5758
    1.9003
   -1.3761
    1.5652
    0.0000];

x0 = [ 0.6732
    0.4484
   -0.1293
    0.2745
    0.5222
    0.0000
   -0.2654
    0.5016
   -0.1544
   -0.0077
   -0.5245
    0.0000
   -0.2657
    0.5018
   -0.1511
   -0.0008
   -0.3927
    0.0051
    1.5714
    1.1824
    1.5730
   -0.0021
   -1.0495
    0.8480
    1.9331
   -1.1421
    1.5727
   -0.0043];

x0 = [0.6732
    0.4484
   -0.1173
    0.2598
    0.5298
   -0.0003
   -0.3039
    0.5733
   -0.1471
   -0.0151
   -0.5257
   -0.0009
   -0.3074
    0.5816
   -0.1496
   -0.0065
   -0.3455
    0.0080
    1.5763
    1.1690
    1.5763
   -0.0192
   -1.0455
    0.8506
    1.9295
   -1.1518
    1.5817
    0.0046];

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
w = [100; 500; 10; 1; 1; 1;];
[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('opti_criterion',x0,sigma,opts,w)

% % % sigma = .5;
% % % stopfitness = 1e-5;
% % % xmean = rand(1,29);
% % % 
% % % % xmin = purecmaes('opti_criterion',29,zeros(29,1),sigma,stopfitness)