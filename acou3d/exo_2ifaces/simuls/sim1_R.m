%
% sim1_R.m
%
% Copyright (C) 2013 Mathieu Gaborit (matael) <mathieu@matael.org>
%
%
% Distributed under WTFPL terms
%
%            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
%                    Version 2, December 2004
%
% Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
%
% Everyone is permitted to copy and distribute verbatim or modified
% copies of this license document, and changing it is allowed as long
% as the name is changed.
%
%            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
%   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
%
%  0. You just DO WHAT THE FUCK YOU WANT TO.
%

clear all;
close all;

% milieu 1 : air
rho1 = 1.293;
c1 = 343;

% milieu 2 : eau
rho2 = 1;
c2 = 1480;

c0 = c1;

% calcul des nombres d'onde
z1 = rho1*c1;
z2 = rho2*c2;

% fonction de passage theta1 => theta2
deg2rad = @(x) pi*x/180;
rad2deg = @(x) 180*x/pi;
snell = @(theta1, k1, k2) rad2deg(asin(k1/k2*sin(deg2rad(theta1))));

% vecteur d'angle (theta1)
theta1 = (0:.5:90);
theta2 = snell(theta1, c1/c0, c1/c0);

% cos/z des angles
cos1z1 = cos(deg2rad(theta1))/z1;
cos2z2 = cos(deg2rad(theta2))/z2;

% calcul de R
R = (cos1z1-cos2z2)/(cos1z1+cos2z2);

plot(theta1, R);

