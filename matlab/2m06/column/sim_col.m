% Generate the open-loop connection for
% the Distillation Column simulation
%
mod_col
%
k1 = 1; k2 = 1;
Theta1 = 1; Theta2 = 1;
%
[num1,den1] = pade(Theta1,6);
del1 = nd2sys(num1,den1);
[num2,den2] = pade(Theta2,6);
del2 = nd2sys(num2,den2);
Del1 = mmult(k1,del1);
Del2 = mmult(k2,del2);
Del = daug(Del1,Del2);
Gd = mmult(G,Del);
%
systemnames = ' Gd W_Delta Wn ';
inputvar = '[ pert{2}; ref{2}; noise{2}; control{2} ]';
outputvar = '[ W_Delta; Gd; control; -Gd-Wn; ref ]';
input_to_Gd = '[ pert+control ]';
input_to_W_Delta = '[ control ]';
input_to_Wn = '[ noise ]';
sysoutname = 'sim_ic';
cleanupsysic = 'yes';
sysic