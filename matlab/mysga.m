function fpop=mysga(initpop,maxgen,objfun,ggap,mutpr,rrate)

population=initpop;
for i=1:maxgen
    objvals=feval(objfun,population);
    [objvals,index]=sort(objvals);
    population=population(index,:);
    fvals=fitness(objvals);
    selected=sus(fvals,floor(size(population,1)*ggap));
    offspring=recombine(population,selected);
    objvals_f=feval(objfun,offspring);
    [objvals_f,index]=sort(objvals_f);
    offspring=mutate(offspring,mutpr);
    offspring=offspring(index,:);
    population=reinsert(population,offspring,floor(size(population,1)*(1-rrate)));
end;
fpop=population;


