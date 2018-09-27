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
    %parent_pairs(pair_id,chromosome_id,parent_id(1 vs 2))
    par(i,:,1)=population(p(i,1),:);
    par(i,:,2)=population(p(i,2),:);
end;

%Recombination
for i=1:N
    r=rand*1.5-0.25;
    a(i)=r;
    o(i,:)=par(i,:,1)+a(i)*(par(i,:,2)-par(i,:,1));
end;
offspring=o;
    