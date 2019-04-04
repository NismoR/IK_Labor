function plotSignals(px,X,delta,kmax,ls,J,lambda)

Ts = 0.01;
t  = 0:Ts:(kmax - 1)*Ts;
py = X(:,1);

if nargin  > 5,

    figure(1)
    subplot(2,2,[1 2]);
    plot(t,J,ls');
    xlabel('Time (s)','interpreter','latex','FontSize',12);
    ylabel('$$J(k,N)$$ ','interpreter','latex','FontSize',12); 
    xlim([t(1) t(end)]);
    title('Cost');

    subplot(223);
    plot(t,lambda(:,1),'k-'); hold on;
    plot(t,lambda(:,2),'r-.');
    plot(t,lambda(:,3),'b--');
    plot(t,lambda(:,4),':','color',[0 0.5 0]);
    xlim([t(1) t(end)]);
    ylabel('$$|z|$$','interpreter','latex','FontSize',12); 
    xlabel('Time (s)','interpreter','latex','FontSize',12);  
    title('Closed loop poles (disc.)');
    
    subplot(224);
    s = log(lambda(1,:))/Ts;
    plot(real(s(1)),imag(s(1)),'kx','markersize',8); hold on;
    plot(real(s(2)),imag(s(2)),'rx','markersize',8);
    plot(real(s(3)),imag(s(3)),'bx','markersize',8); 
    plot(real(s(4)),imag(s(4)),'x','markersize',8,'color',[0 0.5 0]);
    ylabel('Imag $$(s)$$','interpreter','latex','FontSize',12); 
    xlabel('Real $$(s)$$','interpreter','latex','FontSize',12);  
    title('Closed loop poles (cont.)');
    
end

figure(2);
subplot(211);
plot(t,X(:,1),ls'); hold on;
ylabel('$$e_1$$ (m)','interpreter','latex','FontSize',12); 
title('States');

subplot(212);
plot(t,X(:,3),ls); hold on;
ylabel('$$e_2$$ (rad)','interpreter','latex','FontSize',12); 
xlabel('Time (s)','interpreter','latex','FontSize',12); 

figure(3)
subplot(211);
plot(t,X(:,2),ls); hold on;
ylabel('$$\dot{e}_1$$ (m/s)','interpreter','latex','FontSize',12);
title('States');

subplot(212);
plot(t,X(:,4),ls); hold on;
ylabel('$$\dot{e}_2$$ (rad/s)','interpreter','latex','FontSize',12);
xlabel('Time (s)','interpreter','latex','FontSize',12); 

figure(4)
plot(t,delta,ls); hold on;
ylabel('$$\delta$$ (rad)','interpreter','latex','FontSize',12);
xlabel('Time (s)','interpreter','latex','FontSize',12); 
title('Input');

figure(5)
plot(px,py,ls);  hold on;
xlabel('$$x$$ (m)','interpreter','latex','FontSize',12); 
ylabel('$$y$$ (m)','interpreter','latex','FontSize',12);
title('Output trajectory')
    
end