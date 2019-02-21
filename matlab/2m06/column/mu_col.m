% mu-analysis of the distillation column
% closed-loop system
%
clp_ic = starp(sys_ic,K);
omega = logspace(-3,3,100);
clp_g = frsp(clp_ic,omega);
%
% nominal performance
nom_perf = sel(clp_g,[3:6],[3:6]);
figure(1)
vplot('liv,m',vnorm(nom_perf),'r-')
grid
title('Nominal performance')
xlabel('Frequency (rad/min)')
%
% robust stability
rob_stab = sel(clp_g,[1:2],[1:2]);
% Complex perturbations
blkrs = [1 1;1 1];
rbnds = mu(rob_stab,blkrs);
figure(2)
vplot('liv,lm',sel(rbnds,1,1),'r-',sel(rbnds,1,2),'c--')
grid
title('Robust stability')
xlabel('Frequency (rad/min)')
ylabel('mu')
disp(' ')
disp(['mu-robust stability: ' ...
     num2str(pkvnorm(sel(rbnds,1,1)))])
disp(' ')
%
% robust performance
rob_perf = sel(clp_g,[1:6],[1:6]);
blks = [blkrs;4 4];
rpbnds = mu(rob_perf,blks);
figure(3)
vplot('liv,m',sel(rpbnds,1,1),'r-',sel(rpbnds,1,2),'c--')
grid
title('Robust performance')
xlabel('Frequency (rad/min)')
ylabel('mu')
disp(' ')
disp(['mu-robust performance: ' ...
     num2str(pkvnorm(sel(rpbnds,1,1)))])
disp(' ')
