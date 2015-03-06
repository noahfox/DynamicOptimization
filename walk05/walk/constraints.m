function [ ineq,eq ] = constraints( x )
write_params(x);
[out,cmdout] = system('simulate p0');
[~,crash ] = outputreader( cmdout );
ineq = 0;
eq = crash;


end

