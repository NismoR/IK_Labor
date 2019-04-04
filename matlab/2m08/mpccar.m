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


% 1) Diszkr�tidej� szakasz:
% A = ??
% B = ??

% 2) F, G, Rh, Qh m�trixok:
% F = ??
% G = ??
% Rh = ??
% Qh = ??

% 3) Gamma, Phi, Psi m�trixok �s KN vektor:
% Gamma = ??
% Phi = ??
% Psi = ??
% KN =  ?
mpc_init;

% 4) MPC algoritmus:
for k = 1:kmax
     
    % 4a) Optim�lis beavatkoz� jel (vektor)
    % 4b) Z�rt k�r saj�t�rt�kei (A - B*KN)
    % 4c) Aktu�lis k�lts�g
    % 4d) �llapotok ment�se �s friss�t�se (els� beavatkoz�s alkalmaz�sa)
    
end

% 5) Kimenetek
% px = ??
% py = ??
% pyi = ??
% delta = ??

end

