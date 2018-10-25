function fis=initANFIS(U,Y,radius)
 
[m, n]=size(U);
 
[center, sigma]=subclust([U,Y],radius);
center(:,end)=[];
sigma(:,end)=[];
clasters = size(center,1);
for k=1:m
    for j=1:n
        for i=1:clasters
            mu(i,j,k)=gaussmf(U(k,j),[sigma(j) center(i,j)]);
        end
    end
end
 
for k=1:m
    for i=1:clasters
        w(i,k)=prod(mu(i,:,k));
    end
end
 
for k=1:m
    for i=1:clasters
        w(i,k)=w(i,k)/sum(w(:,k));
    end
end
U1 = [U ones(m,1)];
 
for i=1:clasters
    for j=1:m
        for k=1:(n+1)
            fi(j,k+(i-1)*(n+1))=w(n,i)*U1(j,k);
        end
    end
end
 
OUT = inv(fi'*fi)*fi'*Y;
 
fis=create_anfis(center,sigma,OUT,[U Y])
end
