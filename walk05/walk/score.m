function money = score( x )
write_params(x);
[out,cmdout] = system('simulate p0');
[cost,~ ] = outputreader( cmdout );
money = cost;


end

