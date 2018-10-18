x1 = linspace(0, 4*pi);
x2 = linspace(0, 4*pi);
 
[X1, X2] = meshgrid(x1);
Y = cos((X1-X2) / 3) - sin((X1+X2) / 3) + cos((X1.*X2) / 8);
 
surf(X1,X2,Y);
 
X = [X1(:), X2(:)];
Y = Y(:);
index = randperm(length(X(:,1)));
 
X_mix = X(indexes,:);
Y_mix = Y(indexes,:);
 
M = 50;
alfa = 0.05;
tr = 0.9;
%f_approx1 = fBP(X_mix, Y_mix, M, alfa, tr);
