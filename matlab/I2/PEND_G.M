function g=app1g(x);

l=0.5; mc=1; m=0.1;

g=(cos(x(1))/(mc+m)) / ...
  l*(4/3-m*cos(x(1))^2/(mc+m));