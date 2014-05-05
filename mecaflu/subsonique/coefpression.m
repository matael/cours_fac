%
% coefpression.m
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

data_coef = data_load('mesures/coefpression.data', 4)

angles = data_coef(:,1);
h_theta = data_coef(:,2);
ha = data_coef(:,3);
hc = data_coef(:,4);

coef = (h_theta-hc)./(ha-hc);

stem(angles, coef);
hold on;

angles_theo = 0:360;
plot(angles_theo, (1-4*(sin(angles_theo*(pi/180))).^2), '-r');

legend('Mesures', 'Theorie potentielle', 'location', 'southeast');
ylabel('Coefficient de pression');
xlabel('Angle');
grid on;

print('-dpng', 'coefpression.png');

