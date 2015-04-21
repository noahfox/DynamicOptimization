function [LD] = liederiv(fun1,fun2,diff_vars,varargin)
if nargin == 3
    dhdx = jacobian(fun2,diff_vars);
    LD = dhdx*fun1;
else
    order = varargin{1};
    for i = 1:order
        dhdx = jacobian(fun2,diff_vars);
        LD = dhdx*fun1;
        fun2 = LD;
    end
end