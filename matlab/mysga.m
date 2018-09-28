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
    plot(t,y);
    title('Az algoritmus végén legjobbnak ítélt szabályzó ugrásválasza');
    figure(3);
    plot(err);
    title('A generációnkénti legjobb költségfüggvény érték');
    figure(4);
    plot(avg_err);
    title('A generációnkénti átlag költségfüggvény érték');
    figure(5);
    plot(t,u);
    title('Az algoritmus végén legjobbnak ítélt szabályzó beavatkozójele');
end;
