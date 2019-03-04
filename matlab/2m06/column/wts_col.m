% Weighting functions for Distillation Column system
%
% uncertainty weight

nuW_Delta_i_new = [2.4437 10.4649 24.8224  6.7252];
dnW_Delta_i_new = [1.      5.2790 14.5868 15.8093];
nuW_Delta_i_old = [2.2138 15.9537 27.6702  4.9050];
dnW_Delta_i_old = [1.      8.3412 21.2393 22.6705];

nuW_Delta_i_new = [2.3324 8.2039 19.7241  4.2575];
dnW_Delta_i_new = [1.      4.5896 12.3380 13.4265];
nuW_Delta_i_new = [2.3111 7.9043 7.2489  1.3516];
dnW_Delta_i_new = [1.      4.3667 7.8794 4.3613];
nuW_Delta_i_new = [2.3509    8.4222   13.6532    3.0960];
dnW_Delta_i_new = [1.      4.6982   10.2369    9.4826];
    


nuW_Delta_i = nuW_Delta_i_new;
dnW_Delta_i = dnW_Delta_i_new;

% nuW_Delta1 = [2.2138 15.9537 27.6702  4.9050];
% dnW_Delta1 = [1.      8.3412 21.2393 22.6705];
nuW_Delta1 = nuW_Delta_i;
dnW_Delta1 = dnW_Delta_i;
gainW_Delta1 = 1;
w_Delta1 = nd2sys(nuW_Delta1,dnW_Delta1,gainW_Delta1);
%
% nuW_Delta2 = [2.2138 15.9537 27.6702  4.9050];
% dnW_Delta2 = [1.      8.3412 21.2393 22.6705
nuW_Delta2 = nuW_Delta_i;
dnW_Delta2 = dnW_Delta_i;
gainW_Delta2 = 1;
w_Delta2 = nd2sys(nuW_Delta2,dnW_Delta2,gainW_Delta2);
%
W_Delta = daug(w_Delta1,w_Delta2);
%
% model
nuWm1 = 1;
dnWm1 = [6.0^2  2*0.8*6.0  1]; 
gainWm1 = 1.0;
wm1 = nd2sys(nuWm1,dnWm1,gainWm1);
nuWm2 = 1;
dnWm2 = [6.0^2  2*0.8*6.0  1]; 
gainWm2 = 1.0;
wm2 = nd2sys(nuWm2,dnWm2,gainWm2);
wm12 = 0.;
wm21 = 0.;
Wm1 = sbs(wm1,wm12);
Wm2 = sbs(wm21,wm2);
Wm = abv(Wm1,Wm2);
%
% performance weight
tol = 10^(-4);
nuWp = [9.5 3];
dnWp = [9.5 tol];
gainWp = 0.55;
wp = nd2sys(nuWp,dnWp,gainWp);
wp12 = 0.3;  
wp21 = 0.3;
Wp1 = sbs(wp,wp12);
Wp2 = sbs(wp21,wp);
Wp = abv(Wp1,Wp2);
%
% control action weight
nuWu = [1  1];     
dnWu = [0.01   1];
gainWu = 8.7*10^(-1);
wu = nd2sys(nuWu,dnWu,gainWu);
Wu = daug(wu,wu);
%
% noise shaping filter
nuWn = [1 0];
dnWn = [1 1];
gainWn = 10^(-2);
wn = nd2sys(nuWn,dnWn,gainWn);
Wn = daug(wn,wn);
