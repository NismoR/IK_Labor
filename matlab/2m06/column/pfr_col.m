% Perturbed frequency responses of the closed-loop system
%
mod_col
%
% Unscale the plant and controller transfer matrices
Du = diag([1 1]); Si = Du;
De = diag([0.01 0.01]); So = minv(De);
S = daug(So,So);
G_u = mmult(minv(So),G,minv(Si));
K_u = mmult(K,S); 
Wn_u = mmult(minv(So),Wn);
%
% Set the parameters values
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
    Gd_u = mmult(G_u,Del);
%
%   singular values of the sensitivity function
    systemnames = ' Gd_u K_u ';
    inputvar = '[ ref{2}; dist{2} ]';
    outputvar = '[ Gd_u+dist; K_u ]';
    input_to_Gd_u = '[ K_u ]';
    input_to_K_u = '[ -Gd_u-dist; ref ]';
    sysoutname = 'clp_ic';
    cleanupsysic = 'yes';
    sysic
%
    sen_loop = sel(clp_ic,[1:2],[3:4]);
    sen_g = vsvd(frsp(sen_loop,omega));
    figure(1)
    vplot('liv,lm',sel(sen_g,1,1),'r-',sel(sen_g,2,1),'m--')
    grid on
    title('Singular Value Plot of the Sensitivity Function')
    xlabel('Frequency (rad/min)')
    hold on
%
%   singular values of KyS
    systemnames = ' Gd_u K_u ';
    inputvar = '[ ref{2}; noise{2} ]';
    outputvar = '[ K_u ]';
    input_to_Gd_u = '[ K_u ]';
    input_to_K_u = '[ -Gd_u-noise; ref ]';
    sysoutname = 'clp_ic';
    cleanupsysic = 'yes';
    sysic
%
    sen_loop = sel(clp_ic,[1:2],[3:4]);
    sen_g = vsvd(frsp(sen_loop,omega));
    figure(2)
    vplot('liv,lm',sel(sen_g,1,1),'r-',sel(sen_g,2,1),'m--')
    grid on
    title('Singular Value Plot of KyS')
    xlabel('Frequency (rad/min)')
    hold on
end
figure(1), hold off
figure(2), hold off