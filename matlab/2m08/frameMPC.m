% Ir�ny�t�stechnika �s k�pfeldolgoz�s laborat�rium 2.
% J�rm�vek predikt�v ir�ny�t�sa M8
% �ssze�ll�totta: Max Gy�rgy
clear
close all
clc

% 1) Inicializ�l�s
% A j�rm� 3.5 m�ter oldalir�ny� �s 1 fokos orient�ci�s hib�val indul.
% A sebess�ge 30 m/s.
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

% 2) Korl�toz�sok n�lk�li MPC (fekete folytonos vonal)
[px,py,psi,delta,E,J,lambda] = mpccar(N,kmax,P,Q,R,x0);
px1=px;py1=py;psi1=psi;delta1=delta;
plotSignals(px,E,delta,kmax,'k-',J,lambda);

% 3) MPC �llapot- �s bemenet korl�toz�sokkal (piros pontozott vonal)
[px1,py1,psi1,delta1,E1] = mpccarconst(N,kmax,P,Q,R,x0,umin,umax,xmin,xmax);
plotSignals(px,E1,delta1,kmax,'r-.');

% 4) Anim�ci�
d_max=max(abs(delta1))
plotMotion(px1,py1,psi1,delta1);