%
% coeftrainee.m
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

rho_eau = 1000;
rho_air = 1.293;
g = 9.81;

data_coef = data_load('mesures/coeftrainee.data', 3);

angles = data_coef(:,1);
portance = data_coef(:,2);
trainee = data_coef(:,3);

% hack pour avoir la vitesse d'écoulement
pa = 186;
pc = 122;
Uc2 = 2*g*rho_eau/rho_air*(pa-pc);

% surface projetée
L = 23e-2;
D = 5e-2*sin(angles*pi/180);
S = L*D;

coef_trainee = trainee./(0.5*rho_air*Uc2*S);
coef_portance = portance./(0.5*rho_air*Uc2*S);

figure(1);
plot(angles, coef_trainee);
figure(2);
plot(angles, coef_portance);

figure(3);
plot(angles, S);
