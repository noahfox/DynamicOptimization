function write_params(params,correction)

% ----------------------------------------------------------------------- %
% PARAMETER LIST
% ----------------------------------------------------------------------- %
param_names = {'swing_time', 'thrust1', 'swing_hip_target', 'swing_hv1',...
               'swing_ha1', 'swing_knee1', 'swing_kv1', 'swing_ka1',...
               'swing_knee_target', 'swing_kv2', 'swing_ka2',...
               'stance_hip_target', 'stance_hv1', 'stance_ha1',...
               'pitch_d', 'stance_kv1', 'stance_ka1',...
               'stance_knee_target', 'stance_kv2', 'stance_ka2',...
               'stance_ankle_torque'};
  
% ----------------------------------------------------------------------- %
% WRITE TO FILE 'p0'
% ----------------------------------------------------------------------- %           
p_file = fopen('p0','w');

fprintf(p_file, '\n'); % OPEN FILE

% WRITE CONTENTS
for i = 1:1:length(params)
     if correction == 1
        if any(sign == i)
            params(i) = -abs(params(i));
        else
            params(i) = abs(params(i));
        end
     end
    write_line = [param_names{i},' ',num2str(params(i)),' opt end\n'];
    fprintf(p_file,write_line);
end
fclose(p_file); % CLOSE FILE

end