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
x0   = [3.5; 30*sin(1/180*pi); 1/180*pi; 0];    
kmax = 500;
N    = 100;

% Q = ?
% P = Q
% R = ?
 
umin = -0.1;
umax =  0.1;
xmin = [-0.7  -2 -0.1 -10]';
xmax = [ 4.2   2  0.1  10]';

% 2) Korlátozások nélküli MPC (fekete folytonos vonal)
[px,py,psi,delta,E,J,lambda] = mpccar(N,kmax,P,Q,R,x0);
plotSignals(px,E,delta,kmax,'k-',J,lambda);

% 3) MPC állapot- és bemenet korlátozásokkal (piros pontozott vonal)
% [px1,py1,psi1,delta1,E1] = mpccarconst(N,kmax,P,Q,R,x0,umin,umax,xmin,xmax);
% plotSignals(px,E1,delta1,kmax,'r-.');

% 4) Animáció
% plotMotion(px1,py1,psi1,delta1);