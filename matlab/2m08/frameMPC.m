% Irányítástechnika és képfeldolgozás laboratórium 2.
% Jármûvek prediktív irányítása M8
% Összeállította: Max György
clear
close all
clc

% 1) Inicializálás
% A jármû 3.5 méter oldalirányú és 1 fokos orientációs hibával indul.
% A sebessége 30 m/s.
% x = [e1, d_e1, e2, d_e2];
s=30;
x0   = [3.5; s*sin(1/180*pi); 1/180*pi; 0];    
kmax = 500;
N    = 100;
% N    = 50;
% N=3;

Q = blkdiag(3,.5,3,6);
R=300;
% Q=eye(4);
P = Q;
 
umin = -0.1;
umax =  0.1;
xmin = [-0.7  -2 -0.1 -10]';
xmax = [ 4.2   2  0.1  10]';

% 2) Korlátozások nélküli MPC (fekete folytonos vonal)
[px,py,psi,delta,E,J,lambda] = mpccar(N,kmax,P,Q,R,x0);
px1=px;py1=py;psi1=psi;delta1=delta;
plotSignals(px,E,delta,kmax,'k-',J,lambda);

% 3) MPC állapot- és bemenet korlátozásokkal (piros pontozott vonal)
[px1,py1,psi1,delta1,E1] = mpccarconst(N,kmax,P,Q,R,x0,umin,umax,xmin,xmax);
plotSignals(px,E1,delta1,kmax,'r-.');

% 4) Animáció
d_max=max(abs(delta1))
plotMotion(px1,py1,psi1,delta1);