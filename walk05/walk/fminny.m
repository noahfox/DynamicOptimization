clc
clear
clf
close all

% FMIN PARTY
xin = rand(20,1);       % Update to P0
write_params(xin);  

pout = fmincon(@score,xin,[],[],[],[],[],[],@constraints);
system('simulate p0')