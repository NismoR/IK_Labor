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


% 1) Diszkr�tidej� szakasz: (megegyezik az el�z�vel) 
% 2) F, G, Rh, Qh m�trixok: (megegyezik az el�z�vel) 
% 3) Gamma, Phi m�trixok: (megegyezik az el�z�vel) 

% 4) MPC algoritmus:
options = optimset('display','off');
for k = 1:kmax
     
    % 4a) Ac, Bx, bc m�trixok/vektorok
    % 4b) H, f, b sz�m�t�sa
    % 4b) Optim�lis beavatkoz� jel (vektor)
    u = quadprog(H,f,Ac,b,[],[],[],[],[],options);
    % 4d) �llapotok ment�se �s friss�t�se (els� beavatkoz�s alkalmaz�sa)
    
end

% 5) Kimenetek (megegyezik az el�z�vel) 

end

