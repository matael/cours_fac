%
% balayage_xz_365.m
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

data = data_load('balayage_xz_365.data', 12);

x = [-4 -3 -2 -1 -0.5 0 0.5 1 2 3 4];
z = data(:,1);
[xx,zz] = meshgrid(x, z);

voltage = data(:,2:end);

surf(xx,zz,voltage);
title("Balayage du plan xz  (y=0) pour f=36.5kHz");
xlabel('Distance suivant x (cm, +-1cm)');
ylabel('Distance suivant z (cm, +-1cm)');
zlabel('Voltage (mV, +-4mV)');




