%%% criterion for optimizing using both x[k] and u[k] as variables
function score=criterion(p)

global N;

%% param section: constants
duration = 5.0;
dt = duration/N;
goal = pi;
state_penalty = 0.1;

i_a0 = 1;
i_u0 = i_a0 + N + 1;

score = 0;

for i = 1:N+1
 score = score + state_penalty*dt*(p(i_a0)-goal)*(p(i_a0)-goal);
 i_a0 = i_a0 + 1;
end

for i = 1:N
 score = score + p(i_u0)*p(i_u0)*dt;
 i_u0 = i_u0 + 1;
end

% final end
end
