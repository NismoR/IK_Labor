function new_population=mutate(population,mutrate)

r=rand(size(population));
new_population=population+1*[(r>1-mutrate)].*(rand(size(population))-0.5);


