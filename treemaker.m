function tree = treemaker(p)
global N problem

Q = 8; % number of steps
tree.x = p(1:N);
tree.y = p(N+1:2*N);
tree.u_x = p(2*N+1:3*N);
tree.u_y= p(3*N+1:4*N);
tree.st = p(4*N+1:4*N+Q);

if problem == 3
    tree.slx = p(4*N+Q+1:4*N+2*Q);
    tree.sly = p(4*N+2*Q+1:4*N+3*Q);
end


times(1) = tree.st(1);
tree.time(1) = tree.st(1);
for i = 2:length(tree.st)
    times(i) = tree.st(i);
    tree.time(i) = tree.time(i-1) + tree.st(i);
end

tree.dt = tree.time(end)/N;

if problem == 3
    step_num = 1;
    for i = 0:1:N-1
        if tree.dt*i > tree.time(step_num)
            step_num = step_num+1;
        end
        tree.p_traj_x(i+1) = tree.slx(step_num);
        tree.p_traj_y(i+1) = tree.sly(step_num);
    end
end

tree.duration = sum(tree.st);
end
