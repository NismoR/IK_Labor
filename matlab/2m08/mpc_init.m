car_params;
a22=-(c_f+c_r)/m_c*d_x;
a23=(c_f+c_r)/m_c;
a24=(c_r*l_r-c_f*l_f)/m_c*d_x;
b21=c_f/m_c;
a43=(c_f*l_f-c_r*l_r)/I_zz;
a42=a43/d_x;
a44=-(c_f*l_f*l_f+c_r*l_r*l_r)/(I_zz*d_x);
b41=c_f*l_f/I_zz;

% 1) Diszkrétidejû szakasz:
A = [0 1 0 0;0 a_22 a_23 a24;0 0 0 1;0 a_42 a_43 a_44];
B = [0; b_21; 0; b_41];
n=size(A,1);
m=size(B,1);


% 2) F, G, Rh, Qh mátrixok:

%mas megvalositas????
F = zeros(N*n,n);
for i = 1:N
    F((i-1)*n+1:(i)*n,:) = A^i;
end

control = zeros(N*n,m);
for i = 1:N
    control((i-1)*n+1:i*n,:) = A^(i-1)*B;
end
G = zeros(N*n,N*m);
for i = 1:N
    G(:,(i-1)*m+1:i*m) = [zeros((i-1)*n,m); control(1:(N-(i-1))*n,:)];
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
KN =  inv(Gamma)*Phi;