function [ Robut_New,COM_X,COM_Y ] = Robut_Maker(Robut_Old,P)

for i = 1:1:29
    Robut_Old.j(i).angle = P(i);
end

[ Robut_New, COM, ~ ] = drc_forward_kinematics( Robut_Old );
COM_X = COM(1);
COM_Y = COM(2);
end

