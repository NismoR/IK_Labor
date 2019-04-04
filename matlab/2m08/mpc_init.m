car_params;
a_22=-(c_f+c_r)/(m_c*d_x);
a_23=(c_f+c_r)/m_c;
a_24=(c_r*l_r-c_f*l_f)/(m_c*d_x);
b_21=c_f/m_c;
a_43=(c_f*l_f-c_r*l_r)/I_zz;
a_42=a_43/d_x;
a_44=-(c_f*l_f*l_f+c_r*l_r*l_r)/(I_zz*d_x);
b_41=c_f*l_f/I_zz;

% 1) Diszkrétidejû szakasz:
A_cont = [0 1 0 0;0 a_22 a_23 a_24;0 0 0 1;0 a_42 a_43 a_44];
B_cont = [0; b_21; 0; b_41];
n=size(A_cont,2);
m=size(B_cont,2);


dAB = expm(T*[A_cont, B_cont; zeros(1,n), zeros(1,m)]);
A = dAB(1:end-1,1:n);
B = dAB(1:end-1,n+1:end);


% 2) F, G, Rh, Qh mátrixok:

%mas megvalositas????
F = zeros(N*n,n);
for i = 1:N
    F((i-1)*n+1:(i)*n,:) = A^i;
end
% 
% control = zeros(N*n,m);
% for i = 1:N
%     control((i-1)*n+1:i*n,:) = A^(i-1)*B;
% end
% G = zeros(N*n,N*m);
% for i = 1:N
%     G(:,(i-1)*m+1:i*m) = [zeros((i-1)*n,m); control(1:(N-(i-1))*n,:)];
% end


G = zeros(N*4,N);
for i = 1:N
    for j = 1:N
        if (i - j) >= 0
            column_top = (i - 1) * 4 + 1;
            column_bottom = column_top + 3;
            G(column_top:column_bottom,j) = (A^(i - j) * B);
        end
    end
end


Rh = [];
Qh = [];
for i=1:N-1
    Rh=blkdiag(Rh,R);
    Qh=blkdiag(Qh,Q);
end
Rh=blkdiag(Rh,R);
Qh=blkdiag(Qh,P);

% 3) Gamma, Phi, Psi mátrixok és KN vektor:
Psi = F'*Qh*F+Q;
Gamma = G'*Qh*G+Rh;
Phi=G'*Qh*F;
KN =  [eye(m) zeros(1,N-1)]*inv(Gamma)*Phi;