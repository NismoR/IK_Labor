function selected=rws(fvals,Points)

for j=1:length(Points)
    i=1;
    while sum(fvals(1:i))<Points(j)
        i=i+1;
    end;
    selected(j)=i;
end;

