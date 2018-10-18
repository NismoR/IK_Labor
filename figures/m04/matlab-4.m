function f_approx = fNNC(X,y,r,o,tr)
 
X_mix = X(randperm(size(X,1)));
Y_mix = y(randperm(size(y,1)));
X2 = X_mix;
y2 = Y_mix;
A = y2(1);
B = 1;
XFirstRow = X2(1,:);
 
f = zeros(length(X2),1);
for i = 2:tr
	find = 0;
	for j = 1:size(A)        
		if (norm(X2(i,:) - XFirstRow(j,:))<=r)
			clust = j;
			find = 1 ;
		end
	end

	if find==0
		XFirstRow = [XFirstRow; X2(i,:)];
	 B = [B;1];
		A = [A;y2(i)];
	else
		A(clust) = A(clust)+y2(i);
		B(clust) = B(clust)+1;
	end
end
 
sizeA = size(A,1);
for k = 1:size(X,1)
	dataApprox = zeros(sizeA,2);
	dataApprox(1:end,1) = X(k,1);
	dataApprox(1:end,2) = X(k,2);
	f_approx(k) = sum(A.*exp(-(sqrt(sum(abs(dataApprox... 
	XFirstRow).^2,2))/o).^2))...
	/sum(B.*exp(-(sqrt(sum(abs(dataApprox - XFirstRow)...
	.^2,2))/o).^2));
end

