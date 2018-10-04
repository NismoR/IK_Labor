% yprime=derivn(y,n,Ts)
%                                    (1)       (n-1)
% Numerical derivation. yprime=[y   y    .... y     ]' ,
%                                1   1         1 
% where y1 is the last y value. (Ts: sampling time)
%
% Note that y can have multiple rows, each of the rows holding
% a different signal.

function yprime=derivn(y,n,Ts);

[p len]=size(y);
yprime=zeros(p,n);
if len>n
  d=y(:,len-n+1:len);
else
  d=y;
end

for i=1:n
  if isempty(d)
    break;
  else
    len=size(d,2);
    yprime(:,i)=d(:,len)/Ts^(i-1);
  end
  dprev=d; d=[];
  for j=1:p
    d=[d; diff(dprev(j,:))];
  end
end