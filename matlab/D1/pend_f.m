function f=app1f(x);

l=0.5; mc=1; m=0.1;

f=(9.8*sin(x(1))-m*l*x(2)^2*cos(x(1))*sin(x(1))/(mc+m)) / ...
  l*(4/3-m*cos(x(1))^2/(mc+m));