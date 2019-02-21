% Weighting functions for Distillation Column system
%
% uncertainty weight
nuW_Delta1 = [2.2138 15.9537 27.6702  4.9050];
dnW_Delta1 = [1.      8.3412 21.2393 22.6705];
gainW_Delta1 = 1;
w_Delta1 = nd2sys(nuW_Delta1,dnW_Delta1,gainW_Delta1);
%
nuW_Delta2 = [2.2138 15.9537 27.6702  4.9050];
dnW_Delta2 = [1.      8.3412 21.2393 22.6705];
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
