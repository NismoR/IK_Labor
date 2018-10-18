function f = fBP(X, y, M, alfa, tr)
% backprop function
 
    	X_train = X(1:floor(length(y)*tr),:);
    	y_train = y(1:floor(length(y)*tr));
    	X_test = X(floor(length(y)*tr):end,:);
    	y_test = y(floor(length(y)*tr):end);
    	n = size(X_train,2);
    	gauss_avg = X_train(1:M,:);
    	y_upline = rand(M,1).*y(1:M);
    	gauss_sigma = (max(X_train(:,1))-min(X_train(:,1))) / M;
    	gauss_sigma = repmat(gauss_sigma, M, n);
