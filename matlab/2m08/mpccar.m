function [px,py,psi,delta,E,J,lambda] = mpccar(N,kmax,P,Q,R,x0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Bemenetek: 
%      N: horizont hossza               (skal�r)
%   kmax: horizontok sz�ma              (skal�r)
%  P,Q,R: s�lyoz� m�trixok              (P �s Q 4*4-es m�trix, R skal�r)
%     x0: els� horizont kezdeti �rt�ke  (4*1 vektor)
%
% - Kimenetek: 
%     px: x poz�ci� inercia rendszerben (kmax*1 vektor)             
%     py: y poz�ci� inercia rendszerben (kmax*1 vektor)             
%    psi: orient�ci�                    (kmax*1 vektor)            
%  delta: korm�nyz�si sz�g              (kmax*1 vektor)      
%      E: hiba-�llapotvektor            (kmax*4 m�trix)     
%      J: k�lts�g                       (kmax*1 vektor)                
% lambda: saj�t�rt�kek                  (kmax*4 m�trix)          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s=30;
mpc_init;
x_k=x0;
px=zeros(kmax,1);
py=zeros(kmax,1);
psi=zeros(kmax,1);
delta=zeros(kmax,1);
E=zeros(kmax,4);
J=zeros(kmax,1);
lambda=zeros(kmax,4);
dpx=T*s;


% 4) MPC algoritmus:
for k = 1:kmax
     
    % 4a) Optim�lis beavatkoz� jel (vektor)
    u=-inv(Gamma)*Phi*x_k;
    % 4b) Z�rt k�r saj�t�rt�kei (A - B*KN)
    lambda(k,:)=eig(A-B*KN);
    % 4c) Aktu�lis k�lts�g
    J(k)=x_k'*Psi*x_k+u'*Gamma*u+2*x_k'*Phi'*u;
    % 4d) �llapotok ment�se �s friss�t�se (els� beavatkoz�s alkalmaz�sa)
    delta(k)=u(1);
    psi(k)=x_k(3); %mivel az x tengelyen szeretn�nk menni
    py(k)=x_k(1);  %mivel az x tengelyen szeretn�nk menni
    if k==1
        px(k)=0;
    else
        px(k)=px(k-1)+dpx*cos(psi(k));
    end
    x_k=A*x_k+B*u(1);%u* b�l els� u alkalmaz�sa
    E(k,:)=x_k';
end

% 5) Kimenetek
% px = ??
% py = ??
% pyi = ??
% delta = ??

end

