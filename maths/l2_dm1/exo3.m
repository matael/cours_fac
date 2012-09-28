clear all;
close all;

% on crée nos axes x et y
tx = ty = linspace(0, 10, 51);
[xx, yy] = meshgrid(tx, ty);
tz = -500 + (xx.^4).*(yy.^2) + log(1 + 4*xx.^2 + 5*yy.^2);
mesh(tx, ty, tz);
