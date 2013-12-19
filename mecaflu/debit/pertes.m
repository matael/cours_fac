%
% pertes.m
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

g = 9.81;
rho = 1000;

% les données contiennent les données pour :
% - un élargissement brusque
% - un coude
data_pertes = data_load('mesures/charges.data',3);
debits = data_pertes(:,1);

% pertes de charge pour différents débits
Dh = data_pertes(:, 2)/(rho*g);

plot(debits, Dh);
title('Perte de charge dans un coude');

% Coefficient
K = (2*data_pertes(:,2))/() % TODO
