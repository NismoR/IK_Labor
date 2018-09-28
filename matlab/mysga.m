function fpop=mysga(initpop,maxgen,objfun,ggap,mutpr,rrate)

population=initpop;
for i=1:maxgen
    objvals=feval(objfun,population);
    [objvals,index]=sort(objvals);
    err(i)=objvals(1);
    avg_err(i)=mean(objvals);
    population=population(index,:);
    fvals=fitness(objvals);
    selected=select(fvals,floor(size(population,1)*ggap));
    offspring=recombine(population,selected);
    objvals_f=feval(objfun,offspring);
    [objvals_f,index]=sort(objvals_f);
    offspring=mutate(offspring,mutpr);
    offspring=offspring(index,:);
    population=reinsert(population,offspring,floor(size(population,1)*(1-rrate)));
    fprintf('Finished generation %d\n',i);
end;
objvals=feval(objfun,population);
[objvals,index]=sort(objvals);
population=population(index,:);
fpop=population;
err(maxgen+1)=objvals(1);

if strcmp(objfun,'pid_fctn')
    best=population(1,:);
    Ap=best(1);
    Td=best(2);
    Ti=best(3);
    Tc=Td*0.1;
    [t,x,y,r,u]=sim('gentank',[],simset('SrcWorkspace','current'));
    figure(2);
    subplot(2,2,1);
    plot(t,y);
    title('A legjobb ugrásválasz');    
    subplot(2,2,3);
    plot(err);
    xlabel('generáció');
    title('A legjobb költségfüggvényérték');      
    subplot(2,2,4);
    plot(avg_err);
    xlabel('generáció');
    title('Az átlag költségfüggvényérték');    
    subplot(2,2,2);
    plot(t,u);
    title('A legjobb beavatkozójel');    
    fprintf('max(y):%f\n',max(y)); 
    fprintf('max(u):%f\n',max(u));
end;
