function [x, fval, exitflag, h] = optimizer(x0,weights,desired_pos,desired_orientation,opts)
% LOAD ROBOT
drc4

% SET ROOT VARIABLES
robot.j(1).position_w = [ 0 0 0.92712 ];
robot.l(1).orientation = q_to_R( [ 0 0 0 1 ] );

% INITIALIZE GLOBAL VARIABLES
global h w con_opts p_d o_d l_foot_ori r_foot_ori joint_angle_goals COM_D foot_pos

% DESIRED RIGHT WRIST POSITION & ORIENTATION
p_d = desired_pos;
o_d = desired_orientation;

% DRAW ROBOT
h = figure();
draw(robot,p_d);

% JOINT LIMITS
for i = 1:1:29
    lb(i) = robot.j(i).angle_limits(1);
    ub(i) = robot.j(i).angle_limits(2);
end

joint_angle_goals = (lb+ub)./2;

% REQUIRED FOOT POSITIONS
foot_pos = [robot.j(11).position_w;
            robot.j(17).position_w];
l_foot_ori = robot.j(11).rotation;
r_foot_ori = robot.j(17).rotation;
% DESIRED COM
COM_D = [0 0];

% REQUIRE OR DESIRE REACHING GOAL
con_opts = opts;

% SCORE FUNCTION WEIGHTS
w = weights;

% OPTIMIZER OPTIONS
options = optimoptions(@fmincon,'Display','iter','Algorithm','sqp','MaxIter',1000,'MaxFunEvals',10000,'TolCon',10^-4);

% OPTIMIZE
[x, fval, exitflag] = fmincon(@opti_criterion,x0,[],[],[],[],lb,ub,@constraint_fun,options,robot);