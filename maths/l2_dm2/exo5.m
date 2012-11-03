clear all;
close all;


% Champ de force
% grille
[x, y] = meshgrid(-1:0.25:2, -1:0.25:2);
quiver(x, y, 2*x+y, 2*y+x);
grid on;
hold on;
lx = 0:1;
plot(lx, lx, 'r');

print('exo5.png', '-dpng');
