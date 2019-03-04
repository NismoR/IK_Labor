% Generates the open-loop connection for the
% Distillation Column system
%
mod_col
%
% singular values of G
omega = logspace(-4,2,100);
olp_g = frsp(G,omega);
olp_g82 = frsp(G82,omega);
figure(1)
vplot('liv,lm',vsvd(olp_g),'-',vsvd(olp_g82),'--')
grid
title('Singular Value Plots of G and G_4')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
%
% construct weighting functions
wts_col
%
omega = logspace(-4,2,100);
Wm_g = frsp(Wm1,omega);
whitebg('w');


figure(2)
vplot('liv,lm',Wm_g,'r-'), grid
title('Model frequency response')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
%
omega = logspace(-4,2,100);
wn_g = frsp(wn,omega);
%whitebg('w');

figure(3)
vplot('liv,lm',wn_g,'m-'), grid
title('Sensor Noise Weight')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
omega = logspace(-6,2,100);
wp_g = frsp(wp,omega);
wpi_g = minv(wp_g);
%whitebg('w');

figure(4)
vplot('liv,lm',wpi_g,'r-'), grid
title('Inverse of Performance Weighting Function')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
omega = logspace(-4,4,100);
wu_g = frsp(wu,omega);
%whitebg('w');

figure(5)
vplot('liv,lm',wu_g,'r-'), grid
title('Control Action Weighting Function')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
%whitebg('w');
%
% open-loop connection with the weighting functions
systemnames = ' G W_Delta Wm Wn Wp Wu ';
inputvar = '[ pert{2}; ref{2}; noise{2}; control{2} ]';
outputvar = '[ W_Delta; Wp; Wu; -G-Wn; ref ]';
input_to_G = '[ pert+control ]';
input_to_W_Delta = '[ control ]';
input_to_Wm =  '[ ref ]';
input_to_Wn = '[ noise ]';
input_to_Wp = '[ G-Wm ]';
input_to_Wu = '[ control ]';
sysoutname = 'sys_ic';
cleanupsysic = 'yes';
sysic

% whitebg(1,'w');
whitebg(2,'w');
whitebg(3,'w');
whitebg(4,'w');
whitebg(5,'w');