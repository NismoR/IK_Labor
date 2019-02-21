% Loop Shaping Design of the Distillation Column
% 2-degree of freedom controller
mod_col
%
% set the precompensator
nuW1 = [1.1   1];
dnW1 = [10    0];
gainW1 = 1.7;

w1 = nd2sys(nuW1,dnW1,gainW1);
W1 = daug(w1,w1);
%
% form the shaped plant
sysGW = mmult(G,W1);
%
% frequency responses of the plant and shaped plant
omega = logspace(-4,2,100);
G_g = vsvd(frsp(G,omega));
sysGW_g = vsvd(frsp(sysGW,omega));
figure(1)
vplot('liv,lm',G_g,'c-',sysGW_g,'m--'), grid
xlabel('Frequency (rad/min)'), ylabel('Magnitude')
title('Frequency responses of the original plant and shaped plant')
%
% compute the suboptimal feedback controller
factor = 1.1;
[sysK,emax] = ncfsyn(sysGW,factor,'ref');
disp(['Stability margin emax = ' num2str(emax)]);
K = mmult(W1,sysK);
%
% construct the negative feedback controller
[ak,bk,ck,dk] = unpck(K);
bk(:,1:3) = -bk(:,1:3);
dk(:,1:2) = -dk(:,1:2);
K_lsh = pck(ak,bk,ck,dk); K = K_lsh;