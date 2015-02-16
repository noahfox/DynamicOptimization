function result = draw( tree, p_d,COM_X,COM_Y )
% draw( tree ), return value is meaningless

for i = 2:29
 x(1) = tree.j(i).position_w(1);
 y(1) = tree.j(i).position_w(2);
 z(1) = tree.j(i).position_w(3);
 ii = tree.l(i).parent;
 x(2) = tree.j(ii).position_w(1);
 y(2) = tree.j(ii).position_w(2);
 z(2) = tree.j(ii).position_w(3);
 plot3( x, y, z )
 hold on
end
axis( [-1 1 -1 1 0 2 ] );
plot3(p_d(1),p_d(2),p_d(3),'Marker','*','MarkerSize',3,'MarkerEdgeColor','r');
plot3(COM_X,COM_Y,1,'Marker','o','MarkerSize',3,'MarkerEdgeColor','k');
x = [.302/2,.302/2,-.302/2,-.302/2,.302/2];
y = [.262/2,-.262/2,-.262/2,.262/2,.262/2];
z = [1 1 1 1 1];
plot3(x,y,z,'LineWidth',3,'Color','m')
hold off


