function pid=pid_fctn(in)
W=10;
N=size(in,1);
for i=1:N
    Ap=in(i,1);
    Td=in(i,2);
    Ti=in(i,3);
    Tc=0.1*Td;

    try
        [t,x,y,r,u]=sim('gentank',[],simset('SrcWorkspace','current'));
    catch E
        E
        pid(i)=W*4;
        continue;
    end;
    w=warning('query','last');
    warning('off',w.identifier);
    er=abs(r-y);
    z=er.*t;
    int_e1=abs(trapz(t,z));
    e2=subplus(y-1);
    int_e2=abs(trapz(t,e2));
    e3=subplus(abs(u)-10);
    int_e3=abs(trapz(t,e3));
    pid(i)=int_e1+W*(int_e3+int_e2);
    if(pid(i)<0)
        fprintf('P: %f, E1:%f, E2:%f, E3:%f\n',pid(i),int_e1,int_e2,int_e3);
    end;
end;