%
% section_droite.m
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

rho_e = 1000;
g = 9.81;

mesures = data_load('mesures/section_droite.data', 2);
debit = debit_fonce(mesures(:,1));

hL = mesures(:,2);

plot(debit, hL);
xlabel('Debit');
ylabel('h_L');


