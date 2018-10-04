% [b sumb xdiff px]=evalFLS(x,px,po);
%
% Evaluate (2nd type) Fuzzy Logic System

function [b,sumb,xdiff,px]=evalFLS(x,px,po);

[M n]=size(px);

xdiff = repmat(x',[M 1])-px;
b     = exp(-( (xdiff./po).^2 ))'; if n>1, b=prod(b); end
sumb  = sum(b);

% Az alabbi a gyakorlatban nem fordul elo
if sumb < 0.00001
  [xdmin idx] = min(sum(abs(xdiff)')); px(idx,:)=x';
  xdiff = repmat(x',[M 1])-px;
  b     = exp(-( (xdiff./po).^2 ))'; if n>1, b=prod(b); end
  sumb  = sum(b);
end