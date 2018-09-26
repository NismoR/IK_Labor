function selected=select(fvals,N)
sel_proc='sus';
if strcmp(sel_proc,'sus')
    selected=sus(fvals,N);
end;
if strcmp(sel_proc,'rws')
    points=ones(1,N)*rand;
    selected=rws(fvals,sort(points));
end;