% H_infinity design for the Distillation Column system
%
nmeas = 4;
ncon = 2;
gmin = 0.1;
gmax = 10;
tol = 0.001;
[K_hin,clp] = hinfsyn(sys_ic,nmeas,ncon,gmin,gmax,tol);
disp(' ')
minfo(K_hin)
disp(' ')
disp('Closed-loop poles')
sp = spoles(clp)
omega = logspace(-2,6,100);
clp_g = frsp(clp,omega);
vplot('liv,m',vsvd(clp_g),'m-'), grid
title('Singular Value Plot of clp')
xlabel('Frequency (rad/sec)')
ylabel('Magnitude')
K = K_hin;