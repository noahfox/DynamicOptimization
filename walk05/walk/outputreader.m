function [ cost,crash ] = outputreader( cmdout )
kcostlo = strfind(cmdout , 'cost: ') + 6;
kcosthiarray = strfind(cmdout(kcostlo:end),',');
kcosthi = kcosthiarray(1) + kcostlo - 2;
set = cmdout(kcostlo:kcosthi);
cost = str2double(set);


kcrashlo = strfind(cmdout , 'crashed ') + 7;
kcrashloarray = strfind(cmdout(kcrashlo:end),'(');
kcrash = kcrashloarray(1) + kcrashlo-2;
set = cmdout(kcrashlo:kcrash);
crash = str2double(set);

end

