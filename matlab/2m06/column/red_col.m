% Controller order reduction for the Distillation Column system
%
omega = logspace(-2,6,100);
K_g = frsp(K,omega);
[Kb,hsig] = sysbal(K);
n_red = 11;
Kred = hankmr(Kb,hsig,n_red,'d');
Kred_g = frsp(Kred,omega);
%
% frequency responses of the controllers
figure(1)
vplot('liv,lm',vnorm(K_g),'r-',vnorm(Kred_g),'c--')
grid
tmp1 = 'Maximum singular values of the';
tmp2 = ' controller transfer matrices';
title([tmp1 tmp2])
xlabel('Frequency (rad/min)')
%legend('Full-order (n = 28) controller', ...
%       'Reduced-order (n = 11) controller', ...
%       'Location','SouthWest')
%
% model reduction error (in nu-gap metric)   
K_error = nugap(K,Kred)