%
% profilvitesse.m
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

data_profil = data_load('mesures/profilvitesse.data', 3);

z = data_profil(:,1);
Dh = data_profil(:,2) - data_profil(:,3); % Deltah = hA-hC
Dh = Dh*1e-3; % conversion en metres

rho_eau = 1000;
rho_air = 1.293;
g = 9.81;

Vc = sqrt(2*rho_eau/rho_air*g*Dh);

plot(z, Vc, ':+');
ylim([25 33]);
grid on;

ylabel('Vitesse (m/s)');
xlabel('Ordonnee z');
title("Profil de vitesse dans la veine d'experience libre");

print('-dpng', 'profilvitesse.png')




