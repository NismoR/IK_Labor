%Simulation of the perturbed Distillation Column systems
%
mod_col
[k1,k2,Theta1,Theta2] = ndgrid([0.8 1.2],[0.8 1.2],[0 1],[0 1]);
%
for j = 1:16
    [num1,den1] = pade(Theta1(j),2);
    del1 = nd2sys(num1,den1);
    [num2,den2] = pade(Theta2(j),2);
    del2 = nd2sys(num2,den2);
    Del1 = mmult(k1(j),del1);
    Del2 = mmult(k2(j),del2);
    Del = daug(Del1,Del2);
    Gd = mmult(G,Del);
%    
    systemnames = ' Gd K Wn ';
    inputvar = '[ ref{2}; noise{2} ]';
    outputvar = '[ Gd; K ]';
    input_to_Gd = '[ K ]';
    input_to_K = '[ -Gd-Wn; ref ]';
    input_to_Wn = '[ noise ]';
    sysoutname = 'clp';
    cleanupsysic = 'yes';
    sysic
%
%   response to the reference input
    timedata = 0;
    stepdata = 1;
    ref1 = step_tr(timedata,stepdata,0.1,100);
    timedata = 0;
    stepdata = 0;
    ref2 = step_tr(timedata,stepdata,0.1,100);
    noise1 = 0;
    noise2 = 0;
    u = abv(ref1,ref2,noise1,noise2);
    y = trsp(clp,u,100,0.1);
    % y11
    figure(1)
    vplot(sel(y,1,1),'r-'), grid on
    axis([0 100 -0.5 1.5])
    title('Transient responses of the perturbed systems')
    xlabel('Time (min)')
    ylabel('y_{11}')
    hold on
    % y21
    figure(2)
    vplot(sel(y,2,1),'c-'), grid on
    axis([0 100 -0.5 1.5])
    title('Transient responses of the perturbed systems')
    xlabel('Time (min)')
    ylabel('y_{21}')
    hold on
    % u11
    figure(3)
    vplot(sel(y,3,1),'m-'), grid on
    axis([0 100 -0.5 1.5])
    title('Control action in the perturbed systems')
    xlabel('Time (min)')
    ylabel('u_{11}')
    hold on
    % u21
    figure(4)
    vplot(sel(y,4,1),'b-'), grid on
    axis([0 100 -0.5 1.5])
    title('Control action in the perturbed systems')
    xlabel('Time (min)')
    ylabel('u_{21}')
    hold on
    %
    timedata = 0;
    stepdata = 0;
    ref1 = step_tr(timedata,stepdata,0.1,100);
    timedata = 0;
    stepdata = 1;
    ref2 = step_tr(timedata,stepdata,0.1,100);
    noise1 = 0;
    noise2 = 0;
    u = abv(ref1,ref2,noise1,noise2);
    y = trsp(clp,u,100,0.1);
    % y12
    figure(5)
    vplot(sel(y,1,1),'c-'), grid on
    axis([0 100 -0.5 1.5])
    title('Transient responses of the perturbed systems')
    xlabel('Time (min)')
    ylabel('y_{12}')
    hold on
    % y22
    figure(6)
    vplot(sel(y,2,1),'r-'), grid on
    axis([0 100 -0.5 1.5])
    title('Transient responses of the perturbed systems')
    xlabel('Time (min)')
    ylabel('y_{22}')
    hold on
    % u12
    figure(7)
    vplot(sel(y,3,1),'b-'), grid on
    axis([0 100 -0.5 1.5])
    title('Control action in the perturbed systems')
    xlabel('Time (min)')
    ylabel('u_{12}')
    hold on
    % u22
    figure(8)
    vplot(sel(y,4,1),'m-'), grid on
    axis([0 100 -0.5 1.5])
    title('Control action in the perturbed systems')
    xlabel('Time (min)')
    ylabel('u_{22}')
    hold on
end
figure(1), hold off
figure(2), hold off
figure(3), hold off
figure(4), hold off
figure(5), hold off
figure(6), hold off
figure(7), hold off
figure(8), hold off