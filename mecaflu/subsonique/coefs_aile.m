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
pa = 186e-3;
pc = 122e-3;
Uc2 = 2*g*rho_eau/rho_air*(pa-pc);

% surface projetée
L = 23e-2;
D = 5e-2*sin(angles*pi/180);
S = L*D;

% coefs
coef_trainee = trainee./(0.5*rho_air*Uc2*S);
coef_portance = portance./(0.5*rho_air*Uc2*S);

% beta
% beta = arccos(||a||/||a+b||) , a = trainee, b = portance
norme_ab = sqrt(trainee.^2+portance.^2);
norme_a = trainee;
beta = acos(norme_a./norme_ab);

figure(1);
subplot(211);
plot(angles, coef_trainee);
grid on;
ylabel('Coefficient de trainee');
xlabel("Angle d'incidence (deg)");
subplot(212);
plot(angles, coef_portance);
xlabel("Angle d'incidence (deg)");
ylabel('Coefficient de portance');
grid on;

print('-dpng', 'coefs_trainee_portance.png');

figure(2);
subplot(211);
plot(angles, trainee);
xlabel("Angle d'incidence (deg)");
ylabel('Force de trainee');
grid on;
subplot(212);
plot(angles, portance);
xlabel("Angle d'incidence (deg)");
ylabel('Force de portance');
grid on

print('-dpng', 'trainee_portance.png');

figure(3);
subplot(211);
plot(angles, beta);
xlabel("Angle d'incidence (deg)");
ylabel("Angle beta");
grid on;

subplot(212);
plot(angles, coef_portance./coef_trainee);
xlabel("Angle d'incidence (deg)");
ylabel('Finesse');
grid on;

print('-dpng', 'finesse_beta.png');
