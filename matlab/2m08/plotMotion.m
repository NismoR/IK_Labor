function plotMotion(px,py,psi,delta)

y = [px, py, psi, delta];

% Get axis limits
lim = 7.5;
scale = 1;
Tpause = 1e-5;

% Set vehicle colors
red = [210 20 20]/255;

% Plot path and reference path 
figure(17); clf;
plot([0 px(end)],[0 0],'k-.','linewidth',1); hold on

% Get current position and orientation. Draw first frame.
splot = plotArrow(px(1),py(1),psi(1),1,red);

wW = 0.55;
wH = 0.2;
wR = wH/4;
wC = [0.7 0.7 0.7]-0.45;
wA = 1;
hw1 = mywheel([px(1); py(1)],wW,wH,wR,psi(1),0,0.5,'-',[0 0 0],wC,wA,[-1.18;  0.62]);
hw2 = mywheel([px(1); py(1)],wW,wH,wR,psi(1),0,0.5,'-',[0 0 0],wC,wA,[-1.18; -0.62]);
hw3 = mywheel([px(1); py(1)],wW,wH,wR,psi(1),delta(1),0.5,'-',[0 0 0],wC,wA,[ 1.5;   0.62]);
hw4 = mywheel([px(1); py(1)],wW,wH,wR,psi(1),delta(1),0.5,'-',[0 0 0],wC,wA,[ 1.5;  -0.62]);

title('Motion plot');
xlabel('$$x$$ (m)','interpreter','latex','FontSize',12); 
ylabel('$$y$$ (m)','interpreter','latex','FontSize',12);

axis equal;
[xMin, xMax, yMin, yMax] = getBoundingBox(y(1,:));
axis([xMin-lim xMax+lim yMin-lim yMax+lim]); 
pause
delete([splot,hw1,hw2,hw3,hw4]);

% Enter animation loop
NN = 1;
anvec = 1:NN:floor(length(y)/scale);
for j = anvec,     
    
    % Get animation mode
    hplot = plotArrow(px(j),py(j),psi(j),1,red);
    plot(px(1:j),py(1:j),'-','linewidth',1,'color',red); hold on;
    hw1 = mywheel([px(j); py(j)],wW,wH,wR,psi(j),0,0.5,'-',[0 0 0],wC,wA,[-1.18;  0.62]);
    hw2 = mywheel([px(j); py(j)],wW,wH,wR,psi(j),0,0.5,'-',[0 0 0],wC,wA,[-1.18; -0.62]);
    hw3 = mywheel([px(j); py(j)],wW,wH,wR,psi(j),delta(j),0.5,'-',[0 0 0],wC,wA,[ 1.5;   0.62]);
    hw4 = mywheel([px(j); py(j)],wW,wH,wR,psi(j),delta(j),0.5,'-',[0 0 0],wC,wA,[ 1.5;  -0.62]);
    [xMin, xMax, yMin, yMax] = getBoundingBox(y(j*scale,:));
    axis([xMin-lim xMax+lim yMin-lim yMax+lim]);
    pause(Tpause);
    if j ~= anvec(end),
        delete([hplot,hw1,hw2,hw3,hw4]);
    end
end

end

% Defines the size of the animation bounding box. 
function [xMin, xMax, yMin, yMax] = getBoundingBox(z)

xMax = max(z(1,1));
xMin = min(z(1,1));
yMax = max(z(1,2));
yMin = min(z(1,2));

Lim     = abs([xMax-xMin;yMax-yMin]);
centerX = mean([xMax xMin]);
centerY = mean([yMax yMin]);
MAX     = max(Lim);

xMax = centerX + MAX/2;
xMin = centerX - MAX/2;
yMax = centerY + MAX/2;
yMin = centerY - MAX/2;

end

function h = plotArrow( x,y,teta,lw,color)

ct = cos(teta);                                    
st = sin(teta);
R  = [ct -st; st ct];
t  = R'*[x;y];                                     
x0 = t(1);
y0 = t(2);

% Car geometry
xc = [9 13 23 38 55 81 93 105 137 173 221 254 299 347 404 448 496 608 ...
      810 798 804 828 846 860 962 1059 1113 1197 1243 1284 1330 1379 ...
      1411 1444 1465 1475 1478 1481] - 693;                                                  
yc = [380 316 258 211 179 147 135 121 107 94 76 69 66 66 71 80 83 82 ...
      83 27 25 33 52 83 85 86 82 80 85 95 118 147 171 213 254 302 343 ...
      380] - 380;

xc =[xc  fliplr(xc)]/1472*4.5 + x0;                                                  
yc =[yc -fliplr(yc)]/1472*4.5 + y0;

coords1 = R*[xc;yc];
h = patch(coords1(1,:),coords1(2,:),[0 0 0]);
set(h,'linewidth',lw,'facecolor',color);

end

function h = mywheel(c,w,h,r,psi,delta,lw,ls,ec,fc,fa,wxy)

Rpd = [cos(psi+delta) -sin(psi+delta); sin(psi+delta) cos(psi+delta)];
Rp  = [cos(psi) -sin(psi); sin(psi) cos(psi)];

th1 = linspace(0,pi/2,10);
th2 = linspace(pi/2,pi,10);
th3 = linspace(pi,3*pi/2,10);
th4 = linspace(3*pi/2,2*pi,10);

xy = Rp*wxy + c;
x0 = xy(1);
y0 = xy(2);

xc = [r*cos(th1)+w/2-r,  r*cos(th2)-w/2+r,  r*cos(th3)-w/2+r, r*cos(th4)+w/2-r];
yc = [r*sin(th1)+h/2-r,  r*sin(th2)+h/2-r,  r*sin(th3)-h/2+r, r*sin(th4)-h/2+r];

pp = Rpd*[xc;yc];
pp(1,:) = pp(1,:) + x0;
pp(2,:) = pp(2,:) + y0;

h = patch(pp(1,:),pp(2,:),fc,...
    'linewidth',lw,...
    'linestyle',ls,...
    'edgecolor',ec,...
    'facealpha',fa);

end
