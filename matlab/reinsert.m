function new_population=reinsert(population,offspring,elite_count)

new_population=([population(1:elite_count,:); 
offspring(1:size(population,1)-elite_count,:)]);

