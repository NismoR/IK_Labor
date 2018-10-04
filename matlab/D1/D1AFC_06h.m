% Direkt first type adaptive fuzzy controller
% Arguments:
%   K         - [Kn ... K1] must be specified so that all roots
%                   n       n-1
%               of s  + k1*s   + ... + kn = 0 is on the left half plane
%   Q         - An n x n positive definite matrix
%   limit     - [Mo V gamma] limit values (constraints)
%   range     - [minx1 ... minxn;    
%                maxx1 ... maxxn ] Domain of state variables  
%   domN      - Number of membership functions for each state variable
%   domC,domW - Centers and Widths for membership functions
%   f ='pend_f(x)'  function f for the process
%   b=1             function b for the process
%   funrange  - [fU bL] min/max values for function f
%   ym        - reference signal to be followed on the process output (row
%               vector)
%   ts =0.02       - sampling time
%   x0        - Initial value of the state vector
%   ulimit    - [umin; umax] - Allowed range for control signal = [-10 10]'

function [ym,y,x,u,simtime,e]=D1AFC_06h(K,Q,limit,range,domN,domC,domW,f,b,funrange, ym,ts,x0,ulimit)

rand('state',0)
% --- Initialize Variables
simtime=[];
n=length(K);
Mo=limit(1); V=limit(2); gamma=limit(3);
fU=funrange(1); bL=funrange(2);
m=prod(domN);
y=[]; u=[]; v=[];



% --- Step 1: Off-line Preprocessing 

Lambda= zeros(n);
Lambda(1:(n-1),2:end) = eye(n-1);
Lambda(n,:)=-K;
P     = lyap(transpose(Lambda),Q)

% --- Step 2: Initial Controller Construction

%Paramétervektor kezdeti értéke véletlenszerûen van megválasztva:

O=0.2*rand(m,1)-0.1;


% --- Step 3: On-line adaption

x=x0';
for k=1:length(ym)

  % Calculating errors

  y= x  ;         % Kimeneti vektor idõbeni alakulasa
  e=derivn(ym(1:k)-y(1:k),n,ts)'; % A Hibavektor es derivaltjainak idõbeli alakulasa
%   ymn=derivn(ym(1:k),n,ts)';
  ymn=diff(ym(1:k));
  Ve=0.5*((P*e).*e);

  % Forming control signal:

  ksi= evalFBF(x,domC,domW,domN,range);   %Fuzzy rendszer kiertekelese MEG KELL IRNI
  uc=???;           % nevleges fuzzy szabalyozo
  us=???;           % felugyelo szabalyozo
  uk=???;           % beavatkozo jel a k. utemben
  u=???;
 
  % --------------  Simulating the process: ------------------------

  %new
  [tk xk]=ode23(@process,[(k-1)*ts,k*ts],x);
 
  simtime=[simtime;tk(end)];
  x=xk(size(xk,1),:)';
  
  
  % Adjust parameter vector O:

  Onew=???

end


% -------- The  differential equation of the process -----------------


        function xprime=process(t,x);

            xprime = [x(length(uk)+1:length(x)); eval(f)+b*uk];
        end

    
 % ---- Display simulation results -------   
    
 figure(1);plot(simtime,[ym;y])
    
    
end
