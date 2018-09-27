function offspring=recombine(population,selected)

% Making pairs of selected parents
N=length(selected);
r1=randperm(N);
r2=randperm(N);
for i=1:N
    p(i,1)=selected(r1(i));
    p(i,2)=selected(r2(i));
    while(p(i,1)==p(i,2))
        n=floor(rand*N)+1;
        p(i,2)=selected(r2(n));
    end;
end;

%Recombination

    