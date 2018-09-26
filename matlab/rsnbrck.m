function fx=rsnbrck(x)

fx=zeros(size(x,1),1);
for i=1:size(x,2)-1
    fx=fx+(1-x(:,i)).^2+100*(x(:,i+1)-x(:,i).^2).^2;
end;
