clear all;
close all;


% Champ de force
% grille
[x, y] = meshgrid(-1:0.25:4, -1:0.25:4);
quiver(x, y, sin(y), cos(2*x));
grid on;
hold on;
data = [
    0, pi;
    pi, pi;
    0, pi/2;
    0, pi
];
plot(data(:,1), data(:,2), 'r');

print('exo4.png', '-dpng');
