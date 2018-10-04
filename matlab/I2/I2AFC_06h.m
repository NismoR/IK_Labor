
%
% Indirect Second Type Adaptive Fuzzy Controller

% Arguments:
%   K         - [Kn ... K1] must be specified so that all roots
%                   n       n-1
%               of s  + k1*s   + ... + kn = 0 is on the left half plane
%   Q         - An n x n positive definite matrix
%   limit     - [Mo V gamma] limit values (constraints)
%   range     - [minx1 ... minxn;    
%                maxx1 ... maxxn ] Domain of state variables  
%   M         - Number of adjustable parameter sets ("rules")
%   domN      - Number of membership functions for each state variable
%   domC,domW - Centers and Widths for membership functions
%   f ='pend_f(x)'  function f for the process
%   g ='pend_g(x)'  function g for the process
%   funrange  - [fU bL] min/max values for function f
%   yref        - reference signal to be followed on the process output (row
%               vector)
%   ts =0.02       - sampling time
%   x0        - Initial value of the state vector
%   ulimit    - [umin; umax] - Allowed range for control signal = [-10 10]'



function [ym,y,x,u,simtime,e]=I2AFC_06(K,Q,limit,range,M,f,g,funrange, yref,ts,x0,ulimit)

rand('state',0)
ym=yref
simtime=[];
 

% *********************************************************************
%            Initialize Variables
% *********************************************************************

n=length(x0); r=length(K); ymlen=length(ym); 
Mf=limit(1); Mg=limit(2); epsg=limit(3); V=limit(4);
gamma1=limit(5); gamma2=limit(6);
fU=funrange(1); gL=funrange(2); gU=funrange(3);
%huzni?
%m=prod(domN);
y=[]; u=[]; v=[];
fvec=[]; ffvec=[]; gvec=[]; ggvec=[];


% *********************************************************************
%            Step 1: Off-line Preprocessing 
% *********************************************************************

Lambda = ???
bc     = ???
P      = ???


% *********************************************************************
%            Step 2: Initial Controller Construction
% *********************************************************************




rnglen=range(2,:)-range(1,:);
pxf = [];   pxg = [];
for i=1:n,  pxf = [pxf range(1,i)+rnglen(i)*rand(M,1)];  end % M szabály, pxf az f fv becslesere a tagsagi fv-ek kozeppontja Gauss mf-ben
for i=1:n,  pxg = [pxg range(1,i)+rnglen(i)*rand(M,1)];  end
pyf = 0.2*rand(M,1);       pyg=0.2*rand(M,1);                  %M szabály, pyf az f fv becslesere a szabaly kimenete
pof = repmat(rnglen/M,[M 1]); pog=pof; % M szabály, pof az f fv becslesere a tagsagi fv-ek szigmaja Gauss mf-ben
o=min(rnglen/(2*M));        % o a legkisebb szigma, amit megengedunk!


%***********************************************************************
%                   Step 3: On-line adaption
%***********************************************************************

x=x0'; 
for k=1:ymlen

  % ------------------  Calculating errors:  -----------------

  y=[y x(1)];
  e=derivn(ym(1:k)-y(1:k),r,ts)';  
  ymr=diff(ym(max(1,k-r):k),r)/ts^r;
  if (isempty(ymr)), ymr=0; end;
  Ve=???; 

  % -----------------  Estimating functions with fuzzy technique ------
  
  [bf sumbf xfdiff pxf]=???evalFLS(x,pxf,pof)???; 
  %bf a tagsagi fv-ek szorzata egy szabalyban, 
  % sumbg az elozo osseadogatva minden szabalyra, 
  % azaz az f_hat (ff) nevezoje
  [bg sumbg xgdiff pxg]=???evalFLS(x,pxg,pog)???; 
  t=(k-1)*ts;
  ff =???; fvec=[fvec eval(f)];   %Becsult f ertek
  gg = ???;  ggvec=[ggvec gg]; gvec=[gvec eval(g)];    % Becsul G ertek
 
  % ---------------- Forming Control Signal: --------------------------
   
  uc=???; 
  us=???;
  uk=???;
  u=[u uk];
  
  
  
  % --------------  Simulating the process: ------------------------

  %new
  [tk xk]=ode23(@process,[(k-1)*ts,k*ts],x);
 
  simtime=[simtime;tk(end)];
  x=xk(size(xk,1),:)';
  
%   [tk xk]=ode23(model,(k-1)*ts,k*ts,x);
%   x=xk(size(xk,1),:)';
%   
 
 
  % ---------------- Adjust parameter vectors Of,Og: ------------------

  % f parametereinek hangolasa
  
  dfy = ???;  % Az f_hat y parameter szerint derivaltja
  dfx = ???; % Az f_hat x gauss kozeppont parameter szerint derivaltja
  dfo = ???;       % Az f_hat szigma parameter szerint derivaltja
  pxfnew = ???;     % pxf hangolás utáni erteke
  pyfnew = ???;     % pyf hangolás utáni erteke
  pofnew = ???;     %  pof hangolás utáni erteke
  nrfnew = norm([pxf(:); pyf; pof(:)]);
  idx=find(pofnew<o);    pofnew(idx)=o*ones(length(idx),1);
  if (nrfnew<Mf)
    pxf=pxfnew; pyf=pyfnew; pof=pofnew;
  else
     %Luenberger projekcio
    Ofnew= ???;
    Of=???;    
    pxf(:) = Of(1         : M*n);
    pyf    = Of(M*n+1     : M*(n+1));
    pof(:) = Of(M*(n+1)+1 : M*(2*n+1));
  end

    % g parametereinek hangolasa
  dgy = ???;
  dgx = ???;
  dgo = ???;
  pxgnew = ???;
  pygnew = ???;
  pognew = ???;
  nrgnew = norm([pxg(:); pyg; pog(:)]);
  idx=find(pygnew<epsg);    pygnew(idx)=epsg*ones(length(idx),1);
  idx=find(pognew<o);       pognew(idx)=o*ones(length(idx),1);
  if (nrgnew<Mg)
    pxg=pxgnew; pyg=pygnew; pog=pognew;
  else
    %Luenberger projekcio
    Ognew=???;
    Og=???;    
    pxg(:) = Og(1         : M*n);
    pyg    = Og(M*n+1     : M*(n+1));
    pog(:) = Og(M*(n+1)+1 : M*(2*n+1));
  end

end




% -------- The  differential equation of the process -----------------


        function xprime=process(t,x);

            xprime = [x(length(uk)+1:length(x)); eval(f)+eval(g)*uk];
        end

    
 % ---- Display simulation results -------   
    
 figure(1);plot(simtime,[ym;y])
    
    
end