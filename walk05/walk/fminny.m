clc
clear
clf
close all
echo on

% FMIN PARTY
% xin = [.89, -0.047, 0.33, -0.37, -0.10, -0.43, 0.29, 0.26,...
%               -0.080, 0.11, -0.14, -0.22, -0.031, 0.28, 0.085, 0.41,...
%               -0.38, -0.046, -0.29, -0.36, -0.12]; 
xin = rand(21,1);
write_params(xin);  

options = optimoptions(@fmincon,'Display','iter','Algorithm','sqp','MaxIter',10000,'MaxFunEvals',100000,'TolCon',10^-5,'TolX',10^-100);

pout = fmincon(@score,xin,[],[],[],[],[],[],@constraints,options);
system('simulate p0')