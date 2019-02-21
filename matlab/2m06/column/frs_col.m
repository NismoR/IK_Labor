% Frequency responses of the Distillation Column
% closed-loop system
%
mod_col
%
% Approximate the pure delays
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
% Unscale the plant and controller transfer matrices
Du = diag([1 1]); Si = Du;
De = diag([0.01 0.01]); So = minv(De);
S = daug(So,So);
Gd_u = mmult(minv(So),Gd,minv(Si));
K_u = mmult(K,S); 
Wn_u = mmult(minv(So),Wn);
%
systemnames = ' Gd_u W_Delta Wn_u ';
inputvar = '[ pert{2}; ref{2}; noise{2}; control{2} ]';
outputvar = '[ W_Delta; Gd_u; control; -Gd_u-Wn_u; ref ]';
input_to_Gd_u = '[ pert+control ]';
input_to_W_Delta = '[ control ]';
input_to_Wn_u = '[ noise ]';
sysoutname = 'sim_ic';
cleanupsysic = 'yes';
sysic
%
clp_ic = starp(sim_ic,K_u,4,2);
%
% singular values of the closed-loop transfer function
ref_loop = sel(clp_ic,[3:4],[3:6]);
omega = logspace(-2,1,100);
ref_g = vsvd(frsp(ref_loop,omega));
figure(1)
vplot('liv,lm',sel(ref_g,1,1),'r-',sel(ref_g,2,1),'c--')
grid
temp1 = 'Singular Value Plot of the';
temp2 = ' Closed-loop Transfer Function Matrix';
title([temp1,temp2])
xlabel('Frequency (rad/min)')
%
% singular values of the noise transfer function
nos_loop = sel(clp_ic,[3:4],[5:6]);
omega = logspace(-3,3,100);
nos_g = vsvd(frsp(nos_loop,omega));
figure(2)
vplot('liv,lm',sel(nos_g,1,1),'r-',sel(nos_g,2,1),'c--')
grid
title('Singular Value Plot of the Noise Transfer Function')
xlabel('Frequency (rad/min)')
%
% singular values of the sensitivity function
systemnames = ' Gd_u W_Delta K_u ';
inputvar = '[ pert{2}; ref{2}; dist{2} ]';
outputvar = '[ W_Delta; Gd_u+dist ]';
input_to_Gd_u = '[ pert+K_u ]';
input_to_W_Delta = '[ K_u ]';
input_to_K_u = '[ -Gd_u-dist; ref ]';
sysoutname = 'clp_ic';
cleanupsysic = 'yes';
sysic
%
sen_loop = sel(clp_ic,[3:4],[5:6]);
omega = logspace(-3,1,100);
sen_g = vsvd(frsp(sen_loop,omega));
figure(3)
vplot('liv,lm',sel(sen_g,1,1),'r-',sel(sen_g,2,1),'m--')
grid
title('Singular Value Plot of the Sensitivity Function')
xlabel('Frequency (rad/min)')
%
% singular values of the controller
omega = logspace(-3,1,100);
K_g = vsvd(frsp(K_u,omega));
figure(4)
vplot('liv,lm',sel(K_g,1,1),'r-',sel(K_g,2,1),'c--')
grid
title('Singular Value Plot of the Controller')
xlabel('Frequency (rad/min)')
%
% singular values of GKy
Ky = sel(K_u,1:2,1:2);
L = mmult(Gd_u,Ky);
omega = logspace(-3,3,100);
L_g = vsvd(frsp(L,omega));
figure(5)
vplot('liv,lm',sel(L_g,1,1),'r-',sel(L_g,2,1),'m--')
grid
title('Singular Value Plot of GKy')
xlabel('Frequency (rad/min)')
%
% singular values of KyS
systemnames = ' Gd_u W_Delta K_u ';
inputvar = '[ pert{2}; ref{2}; noise{2} ]';
outputvar = '[ W_Delta; K_u ]';
input_to_Gd_u = '[ pert+K_u ]';
input_to_W_Delta = '[ K_u ]';
input_to_K_u = '[ -Gd_u-noise; ref ]';
sysoutname = 'clp_ic';
cleanupsysic = 'yes';
sysic
%
sen_loop = sel(clp_ic,[3:4],[5:6]);
omega = logspace(-2,3,100);
sen_g = vsvd(frsp(sen_loop,omega));
figure(6)
vplot('liv,lm',sel(sen_g,1,1),'r-',sel(sen_g,2,1),'m--')
grid
title('Singular Value Plot of KyS')
xlabel('Frequency (rad/min)')