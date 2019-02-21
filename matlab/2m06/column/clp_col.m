% Transient responses of the closed_loop
% Distillation Column system
%
% response to the reference
sim_col
clp = starp(sim_ic,K,4,2);
%
timedata = 0;
stepdata = 1;
ref1 = step_tr(timedata,stepdata,0.1,150);
timedata = 0;
stepdata = 0;
ref2 = step_tr(timedata,stepdata,0.1,150);
noise1 = 0;
noise2 = 0;
u = abv(0,0,ref1,ref2,noise1,noise2);
y = trsp(clp,u,150,0.1);
% y11
figure(1)
vplot(sel(y,3,1),'r-'), grid
%axis([0 100 -0.5 1.5])
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{11}')
% y21
figure(2)
vplot(sel(y,4,1),'c-'), grid
%axis([0 100 -0.5 1.5])
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{21}')
% u11
figure(3)
vplot(sel(y,5,1),'b-'), grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{11}')
% u21
figure(4)
vplot(sel(y,6,1),'m-'), grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{21}')
%
timedata = 0;
stepdata = 0;
ref1 = step_tr(timedata,stepdata,0.1,150);
timedata = 0;
stepdata = 1;
ref2 = step_tr(timedata,stepdata,0.1,150);
noise1 = 0;
noise2 = 0;
u = abv(0,0,ref1,ref2,noise1,noise2);
y = trsp(clp,u,150,0.1);
% y12
figure(5)
vplot(sel(y,3,1),'r-'), grid
%axis([0 100 -0.5 1.5])
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{12}')
% y22
figure(6)
vplot(sel(y,4,1),'c-'), grid
%axis([0 100 -0.5 1.5])
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{22}')
% u12
figure(7)
vplot(sel(y,5,1),'b-'), grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{12}')
% u22
figure(8)
vplot(sel(y,6,1),'m-'), grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{22}')