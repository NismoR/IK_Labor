function fvals=fitness(obj_vals)

[obj_vals,index]=sort(obj_vals,'descend');
q=1:length(obj_vals);
index(index)=q;

sp=2;
fvals=2-sp+2*(sp-1)*(index-1)/(length(obj_vals)-1);

