function welcome_spring()
n=1800;
r=linspace(0,1,n);
theta=linspace(0,2*pi,n);
[R,THETA]=ndgrid(r,theta);
% define the number of petals we want per cycle. Violets have 5!
petalNum=5;
x = 1 - (1/2)*((5/4)*(1 - mod(petalNum*THETA, 2*pi)/pi).^2 - 1/4).^2;
% update the formula for phi to stop the spiralling effect
phi = (pi/2)*exp(-2*pi/(8*pi));
y = 1.95653*(R.^2).*(1.27689*R - 1).^2.*sin(phi);
R2 = x.*(R.*sin(phi) + y.*cos(phi));
X=R2.*sin(THETA);
Y=R2.*cos(THETA);
Z=x.*(R.*cos(phi)-y.*sin(phi));
% color code for blueviolet RGB 138,43,226
% Indigo rgb value (75,0,130)
mapSize=20;
blue_map=linspace(138,75,mapSize)';
blue_map(:,2)=linspace(43,0,mapSize)';
blue_map(:,3)=linspace(226,130,mapSize)';
% and a pretty bit in the middle
gold_map=[255 215 0; 250 210 0];
% combine to form a full flower map
violet_map=[gold_map; blue_map];
% Now lets plot it and try and pick an attractive angle
surf(X,Y,Z,'LineStyle','none')
colormap(violet_map/255)
view([-12.700 81.200])
end
