function [px,py,psi,delta,E] = mpccarconst(N,kmax,P,Q,R,x0,umin,umax,xmin,xmax)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Bemenetek: 
%         N: horizont hossza               (skal�r)
%      kmax: horizontok sz�ma              (skal�r)
%     P,Q,R: s�lyoz� m�trixok              (P �s Q 4*4-es m�trix, R skal�r)
%        x0: els� horizont kezdeti �rt�ke  (4*1 vektor)
% umin,umax: beavatkoz� jel korl�tok       (skal�r)
% xmin,xmax: �llapot korl�tok              (4*1 vektor)
%
% - Kimenetek: 
%        px: x poz�ci� inercia rendszerben (kmax*1 vektor)             
%        py: y poz�ci� inercia rendszerben (kmax*1 vektor)             
%       psi: orient�ci�                    (kmax*1 vektor)            
%     delta: korm�nyz�si sz�g              (kmax*1 vektor)      
%         E: hiba-�llapotvektor            (kmax*4 m�trix)           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning off %#ok<WNOFF>

s=30;
mpc_init;
x_k=x0;
px=zeros(kmax,1);
py=zeros(kmax,1);
psi=zeros(kmax,1);
delta=zeros(kmax,1);
E=zeros(kmax,4);
dpx=T*s;

% 4) MPC algoritmus:
options = optimset('display','off');
In=repmat(eye(n),N,1);
     
% 4a) Ac, Bx, bc m�trixok/vektorok
Ac=[G;-G];
Bx=[-F;F];
bc=[In*xmax;-In*xmin];
H=2*Gamma;


for k = 1:kmax
    % 4b) H, f, b sz�m�t�sa
    f=2*Phi*x_k;
    b=bc+Bx*x_k;
    % 4b) Optim�lis beavatkoz� jel (vektor)
    u = quadprog(H,f,Ac,b,[],[],[],[],[],options);
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

% 5) Kimenetek (megegyezik az el�z�vel) 

end

