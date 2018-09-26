function fx=rstrgn(x)

fx=zeros(size(x,1),1);
for i=1:size(x,2)
    fx=fx+10+x(:,i).^2-10*cos(2*pi*x(:,i));
end;
