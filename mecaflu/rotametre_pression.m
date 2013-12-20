%
% rotametre_pression.m
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

% mesures
data_rot = data_load('mesures/rotametre.data', 4);
rotametre = data_rot(:,1);

diffpress = data_rot(:,4);


% regression linéaire
reglin_params = polyfit(rotametre, diffpress, 1); % polynome d'ordre 1 : droite
reglin = reglin_params(1)*rotametre+reglin_params(2);

plot(rotametre, diffpress,'+');
hold on;
plot(rotametre, reglin, 'r')
grid on;

title('Trace de la difference en fonction du debit mesure via le rotametre');
legend('Mesure manometrique', ['Regression ~ ' num2str(reglin_params(1)) 'x + ' num2str(reglin_params(2))],'location', 'southeast');
xlabel('Debit mesure par le rotametre (l/h)');

disp(['Regression ~ ' num2str(reglin_params(1)) 'x + ' num2str(reglin_params(2))]);

% image
print('-dpng', 'rota_pression.png');
