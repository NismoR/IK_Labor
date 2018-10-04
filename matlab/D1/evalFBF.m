% evalFBF(X,domC,domW,domN [,range])
%
% Eval Fuzzy Basis Functions to get the ksi(x) column vector

function ksi=evalFBF(X,domC,domW,domN,range);

if (nargin>4), X=max(range(1,:)',min(range(2,:)',X)); end

I=length(domN); mu=zeros(I,max(domN));
for i=1:I
  if ~isnan(X(i))
    for j=1:domN(i)
      mu(i,j)=exp(-((X(i)-domC(i,j))/domW(i,j))^2);
    end
  else
    mu(i,1:domN(i))=ones(1,domN(i));
  end
end

ksi=mu(1,1:domN(1))';
for i=2:I
  D=ksi*mu(i,1:domN(i)); 
  ksi=D(:); 
 
end