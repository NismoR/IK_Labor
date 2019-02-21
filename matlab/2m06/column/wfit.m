mf = ginput(20);                   % pick 20 points
magg = vpck(mf(:,2),mf(:,1));      % pack them as a varying matrix
W = fitmag(magg);                  % choose the order of W online
[A,B,C,D] = unpck(W);              % converting into state space
[num,den] = ss2tf(A,B,C,D)         % converting into transfer function form