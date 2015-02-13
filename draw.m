function result = draw( tree )
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
hold off


