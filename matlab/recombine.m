function offspring=recombine(population,selected)

recomb_proc='inner';
N_var=length(population(1,:));
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
    if strcmp(recomb_proc,'line')
        a(i,:)=ones(1:N_var)*(rand*1.5-0.25);
    end;
    if strcmp(recomb_proc,'inner')        
        for j=1:N_var
            a(i,j)=(rand*1.5-0.25);
        end;
    end;
    o(i,:)=par(i,:,1)+a(i,:).*(par(i,:,2)-par(i,:,1));
end;
a';
offspring=o;
if(0)
    figure(2);
    clf(figure(2));
    hold on
    for i=1:2
        p=1;
        scatter(par(i,1,p),par(i,2,p),'b')
        plot([par(i,1,p) o(i,1)],[par(i,2,p) o(i,2)],'bl')
        p=2;
        scatter(par(i,1,p),par(i,2,p),'r')
        scatter(o(i,1),o(i,2),'g')
        plot([par(i,1,p) o(i,1)],[par(i,2,p) o(i,2)],'bl')
        
    end;
end;