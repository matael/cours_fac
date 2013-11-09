%
% balayage_champ.m
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

data = data_load('balayage_champ.data', 6);

x = [ -7.5, -5, 0, 5, 7.5];
z = data(:,1);

voltage = data(:,2:end);

[xx,zz] = meshgrid(x,z);

surf(xx, zz, voltage);
title("Balayage du plan xz  (y=0)");
xlabel('Distance x (en cm, +-1cm)');
ylabel('Distance z (en cm, +-1cm)');
zlabel('Voltage (en mV, -+4mV)');
