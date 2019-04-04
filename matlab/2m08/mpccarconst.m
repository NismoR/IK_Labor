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


% 1) Diszkrétidejû szakasz: (megegyezik az elõzõvel) 
% 2) F, G, Rh, Qh mátrixok: (megegyezik az elõzõvel) 
% 3) Gamma, Phi mátrixok: (megegyezik az elõzõvel) 

% 4) MPC algoritmus:
options = optimset('display','off');
for k = 1:kmax
     
    % 4a) Ac, Bx, bc mátrixok/vektorok
    % 4b) H, f, b számítása
    % 4b) Optimális beavatkozó jel (vektor)
    u = quadprog(H,f,Ac,b,[],[],[],[],[],options);
    % 4d) Állapotok mentése és frissítése (elsõ beavatkozás alkalmazása)
    
end

% 5) Kimenetek (megegyezik az elõzõvel) 

end

