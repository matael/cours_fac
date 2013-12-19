%
% rotametre_volumetrie.m
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

% données statiques (35cm-1.4cm)^2
surf_cuve = (33.6e-2)^2;

% mesures
data_rot = data_load('mesures/rotametre.data', 4);
rotametre = data_rot(:,1);

temps = data_rot(:,2)/3600; % en heures
volume = data_rot(:,3)*surf_cuve*1000; % en litres
debit = volume./(temps);

plot(rotametre, debit);
hold on;
plot(rotametre, rotametre, 'r');
grid on;

title('Comparaison entre mesure rotamétrique et volumétrique');
legend('Mesure volumetrique', 'Mesure rotametrique', 'location', 'southeast');
xlabel('Débit (l/h)');
