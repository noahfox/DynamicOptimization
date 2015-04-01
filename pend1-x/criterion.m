% optimize using x[k] as variables, represented with samples
function score=criterion(p)

% globals
global N; % (N+1) = number of samples.
global duration; % total duration of movement
global goal

%% param section: constants
dt = duration/N;
state_penalty = 0.1;
length = 1.0;
width = 0.1;
mass = 1.0;
gravity = 9.81;
moment_of_inertia_joint = mass*(length*length + width*width)/12 + mass*length*length/4;

% restore full trajectory
xx(N+1) = goal;
xx(N) = goal;
xx(2) = 0;
xx(1) = 0;
for i = 3:N-1
 xx(i) = p(i-2); % copy new array
end;

% compute acceleration
a(N+1) = 0;
a(1) = 0;
for i=2:N
 a(i)=(xx(i+1)-2*xx(i)+xx(i-1))/(dt^2);
end

% Now do inverse dynamics: compute commands from accelerations
u(N+1) = 0; % command (torque)
for i=1:N
 u(i) = mass*gravity*length*0.5*sin(xx(i))+moment_of_inertia_joint*a(i);
end

score = 0;

for i = 1:N+1
 score = score + state_penalty*dt*(xx(i)-goal)*(xx(i)-goal);
end

for i = 1:N+1
 score = score + u(i)*u(i)*dt;
end

% plot(xx)
% drawnow

% final end
end
