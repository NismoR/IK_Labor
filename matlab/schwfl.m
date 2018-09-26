function fx=schwfl(x)

fx=zeros(size(x,1),1);

%x(x>500)=500;
%x(x<-500)=-500;
for i=1:size(x,2)
    fx=fx+418.9829-x(:,i).*sin(sqrt(abs(x(:,i))));
end;
%q=((abs(x(:,1))>500)+(abs(x(:,2)>500))>0);
%fx=abs(fx);
%fx(q)=1e5;
