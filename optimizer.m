% LOAD ROBOT
drc4

% INITIALIZE GLOBAL VARIABLES
global p_d joint_angle_goals com_d foot_pos

% DESIRED RIGHT WRIST POSITION & ORIENTATION
p_d = [10 10 10];
% o_d = [];

% SET UP CONSTRAINTS
for i = 1:1:29
    lb(i) = robot.j(i).angle_limits(1);
    ub(i) = robot.j(i).angle_limits(2);
end

foot_pos = [robot.j(10).position_w;
            robot.j(16).position_w];
        
joint_angle_goals = (lb+ub)./2;

com_d = [0 0];

% INITIAL GUESS
% x0 = zeros(1,29);
x0 = rand(1,29);

% OPTIMIZE
x = fmincon(@opti_criterion,x0,[],[],[],[],lb,ub,@constraint_fun,robot,p_d,foot_pos);