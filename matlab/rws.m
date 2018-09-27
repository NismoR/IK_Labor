function selected=rws(fvals,Points)

csum=cumsum(fvals);
for j=1:length(Points)
    i=1;
    while csum(i)<Points(j)
        i=i+1;
    end;
    selected(j)=i;
end;

