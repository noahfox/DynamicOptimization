% CMAES Optimizer

% LOAD ROBOT
drc4

% SET ROOT VARIABLES
robot.j(1).position_w = [ 0 0 0.92712 ];
robot.l(1).orientation = q_to_R( [ 0 0 0 1 ] );




% INITIALIZE GLOBAL VARIABLES
global p_d joint_angle_goals COM_D foot_pos robot

% DESIRED RIGHT WRIST POSITION & ORIENTATION
p_d = [0.5 0.3 1];
% o_d = [];

% DRAW ROBOT
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

% Initial guess and search size
x0 = zeros(1,29);
sigma = .03;


opts = cmaes;
opts.StopFitness = 1e-5;


% Run the optimizer
[XMIN,FMIN,COUNTEVAL,STOPFLAG,OUT,BESTEVER] = cmaes('opti_criterion',x0,sigma,opts)
