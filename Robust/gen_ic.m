function x0 = gen_ic()
rng('shuffle','twister')
consts = get_consts() ;
y = (rand(1)*50)-25;
theta = (rand(1)*0.6)-0.3;
dy = (rand(1)*4)-2;
dtheta = (rand(1)*0.1)-0.05;
x0 = [y 150 theta 0 dy 0 dtheta 0 consts.m_nofuel+0.7*consts.max.m_fuel];