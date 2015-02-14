function [x, fval, h] = optimizer(x0,desired_pos)
% LOAD ROBOT
drc4

% SET ROOT VARIABLES
robot.j(1).position_w = [ 0 0 0.92712 ];
robot.l(1).orientation = q_to_R( [ 0 0 0 1 ] );

% INITIALIZE GLOBAL VARIABLES
global w con_opts h p_d joint_angle_goals COM_D foot_pos

% DESIRED RIGHT WRIST POSITION & ORIENTATION
% p_d = [.4 -0.4 1.2];
p_d = desired_pos;

% DRAW ROBOT
h = figure();
draw(robot,p_d);

% SET UP CONSTRAINTS
for i = 1:1:29
    lb(i) = robot.j(i).angle_limits(1);
    ub(i) = robot.j(i).angle_limits(2);
end

foot_pos = [robot.j(10).position_w;
            robot.j(16).position_w];
        
joint_angle_goals = (lb+ub)./2;

COM_D = [0 0];

con_opts = [1];

w = [10; 1; 1; 1; 1; 1;];

% INITIAL GUESS
% x0 = zeros(1,29);
% x0 = rand(1,29);

% OPTIMIZER OPTIONS
options = optimoptions(@fmincon,'Display','iter','Algorithm','sqp','MaxIter',1000,'MaxFunEvals',10000,'TolCon',10^-5);

% OPTIMIZE
[x, fval] = fmincon(@opti_criterion,x0,[],[],[],[],lb,ub,@constraint_fun,options,robot);