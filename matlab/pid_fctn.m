function pid=pid_fctn(in)
N=size(in,1);
for i=1:N
    Ap=in(i,1);
    Td=in(i,2);
    Ti=in(i,3);
    Tc=0.1*Td;

    try
        [t,x,y,r,u]=sim('gentank',[],simset('SrcWorkspace','current'));
    catch
        pid(i)=30;
        int_e1(i)=50;
        int_e2(i)=50;
        int_e3(i)=50;
        continue;
    end;
    w=warning('query','last');
    warning('off',w.identifier);
    er=abs(r-y);
    z=er.*t;
    int_e1(i)=abs(trapz(t,z));
    e2=subplus(y-1);
    int_e2(i)=abs(trapz(t,e2));
    e3=subplus(abs(u)-10);
    int_e3(i)=abs(trapz(t,e3));
end;
W=mean(int_e1)*60;
for i=1:N
    pid(i)=int_e1(i)+W*(int_e3(i)+int_e2(i)*1.2);
    if(pid(i)<0)
        fprintf('P: %f, E1:%f, E2:%f, E3:%f\n',pid(i),int_e1(i),int_e2(i),int_e3(i));
    end;
end;