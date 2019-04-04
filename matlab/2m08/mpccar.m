function [px,py,psi,delta,E,J,lambda] = mpccar(N,kmax,P,Q,R,x0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Bemenetek: 
%      N: horizont hossza               (skalár)
%   kmax: horizontok száma              (skalár)
%  P,Q,R: súlyozó mátrixok              (P és Q 4*4-es mátrix, R skalár)
%     x0: elsõ horizont kezdeti értéke  (4*1 vektor)
%
% - Kimenetek: 
%     px: x pozíció inercia rendszerben (kmax*1 vektor)             
%     py: y pozíció inercia rendszerben (kmax*1 vektor)             
%    psi: orientáció                    (kmax*1 vektor)            
%  delta: kormányzási szög              (kmax*1 vektor)      
%      E: hiba-állapotvektor            (kmax*4 mátrix)     
%      J: költség                       (kmax*1 vektor)                
% lambda: sajátértékek                  (kmax*4 mátrix)          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 1) Diszkrétidejû szakasz:
% A = ??
% B = ??

% 2) F, G, Rh, Qh mátrixok:
% F = ??
% G = ??
% Rh = ??
% Qh = ??

% 3) Gamma, Phi, Psi mátrixok és KN vektor:
% Gamma = ??
% Phi = ??
% Psi = ??
% KN =  ?
mpc_init;

% 4) MPC algoritmus:
for k = 1:kmax
     
    % 4a) Optimális beavatkozó jel (vektor)
    % 4b) Zárt kör sajátértékei (A - B*KN)
    % 4c) Aktuális költség
    % 4d) Állapotok mentése és frissítése (elsõ beavatkozás alkalmazása)
    
end

% 5) Kimenetek
% px = ??
% py = ??
% pyi = ??
% delta = ??

end

