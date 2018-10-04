function fx=djng(x)

s=size(x);
if(s(1)<100)
    s
end;
fx=diag(x*x');