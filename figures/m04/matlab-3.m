for j = 1:50
	for i=1:length(X_train)
	   tau=exp(((repmat(X_train(i,:),M,1)gauss_avg)...
	   ./gauss_sigma).^2);
	   a=sum(prod(tau,2).*y_upline);
	   b=sum(prod(tau,2));
	   f=a/b;
	   e=f-y_train(i);	   
	   df_dy=prod(tau,2)/(sum(prod(tau,2)));		   
	   df_dx=repmat((y_upline-repmat(f,M,1))...
	   .*df_dy,1,n).*((repmat(X_train(i,:),M,1)...
	   -gauss_avg)./gauss_sigma.^2);				   
	   df_ds=repmat((y_upline-repmat(f,M,1))...
	   .*df_dy,1,n).*((repmat(X_train(i,:),M,1)...
	   -gauss_avg).^2./gauss_sigma.^3);				   
	   ae=alfa*e;
	   y_upline = y_upline - ae*df_dy;
	   gauss_avg = gauss_avg - ae*df_dx;
	   gauss_sigma = gauss_sigma - ae*df_ds;
	   e_all(i)=e;
	end
	disp([num2str(j),'. iteracio:'])
	disp(['Hibaosszeg: ',num2str(sum(abs(e_all)))]);
	disp(['Legnagyobb hiba: ',num2str(max(e_all))]);	
	disp(['Atlagos hiba: ',num2str(mean(abs(e_all)))]);
	disp(['Negyzetes hiba:',num2str(mean(e_all.^2)*0.5)]);
	disp(' ');
end
