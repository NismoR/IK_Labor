% Approximation of uncertain time delay by unstructured
% multiplicative perturbation
%
hold off
omega = logspace(-2,2,200);
% 3rd order approximation
W_Delta_old = nd2sys([2.2138 15.9537 27.6702  4.9050], ...
                     [1.      8.3412 21.2393 22.6705]);
W_Delta_new = nd2sys([2.3324 8.2039 19.7241  4.2575], ...
                     [1.      4.5896 12.3380 13.4265]);
W_Delta_new = nd2sys([2.3111 7.9043 7.2489  1.3516], ...
                     [1.      4.3667 7.8794 4.3613]);
W_Delta_new = nd2sys([2.3509    8.4222   13.6532    3.0960], ...
                     [1.      4.6982   10.2369    9.4826]);
W_Delta=W_Delta_new;
             
% W_Delta = nd2sys([2.4437 10.4649 24.8224  6.7252], ...
%                  [1.      5.2790 14.5868 15.8093]);
W_Delta_g = frsp(W_Delta,omega);
%

k_tol=[0.7 1.3];
tau_tol=[0 1.07];
for k = k_tol(1):0.05:k_tol(2);
    for tau = 0:0.1:1.0;
        for i = 1:200
            om = omega(i);
            pert(i) = sqrt((k*cos(om*tau)-1)^2 + (k*sin(om*tau))^2);
        end
        magg = vpck(pert',omega');
        vplot('liv,m',W_Delta_g,'r-',magg,'c--'), grid on
        hold on
    end    
end
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
temp1 = 'Approximation of uncertain time delay';
temp2 = ' by multiplicative perturbation';
title([temp1 temp2])
whitebg();