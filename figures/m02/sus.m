function selected=sus(fvals,N)
S=sum(fvals);
ptr=rand*S/N;
for i=1:N
    fx(i)=ptr+(i-1)*S/N;   
end;
selected=rws(fvals,fx);

