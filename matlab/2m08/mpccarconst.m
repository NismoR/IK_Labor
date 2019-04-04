function [px,py,psi,delta,E] = mpccarconst(N,kmax,P,Q,R,x0,umin,umax,xmin,xmax)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Bemenetek: 
%         N: horizont hossza               (skalár)
%      kmax: horizontok száma              (skalár)
%     P,Q,R: súlyozó mátrixok              (P és Q 4*4-es mátrix, R skalár)
%        x0: elsõ horizont kezdeti értéke  (4*1 vektor)
% umin,umax: beavatkozó jel korlátok       (skalár)
% xmin,xmax: állapot korlátok              (4*1 vektor)
%
% - Kimenetek: 
%        px: x pozíció inercia rendszerben (kmax*1 vektor)             
%        py: y pozíció inercia rendszerben (kmax*1 vektor)             
%       psi: orientáció                    (kmax*1 vektor)            
%     delta: kormányzási szög              (kmax*1 vektor)      
%         E: hiba-állapotvektor            (kmax*4 mátrix)           
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
     
% 4a) Ac, Bx, bc mátrixok/vektorok
Ac=[G;-G];
Bx=[-F;F];
bc=[In*xmax;-In*xmin];
H=2*Gamma;


for k = 1:kmax
    % 4b) H, f, b számítása
    f=2*Phi*x_k;
    b=bc+Bx*x_k;
    % 4b) Optimális beavatkozó jel (vektor)
    u = quadprog(H,f,Ac,b,[],[],[],[],[],options);
    % 4d) Állapotok mentése és frissítése (elsõ beavatkozás alkalmazása)
    delta(k)=u(1);
    psi(k)=x_k(3); %mivel az x tengelyen szeretnénk menni
    py(k)=x_k(1);  %mivel az x tengelyen szeretnénk menni
    if k==1
        px(k)=0;
    else
        px(k)=px(k-1)+dpx*cos(psi(k));
    end
    x_k=A*x_k+B*u(1);%u* ból elsõ u alkalmazása
    E(k,:)=x_k';
end

% 5) Kimenetek (megegyezik az elõzõvel) 

end

