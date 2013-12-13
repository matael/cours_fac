%
% interspectre_m4.m
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

[f, Sm1, Sm2] = interspec_fromfile('mesure4_s1s2_2/Gxy.txt');

% revonstruct pressure cross-spectrum
Syx_p = (Sm1+Sm2) / (2);

subplot(211);
plot(f, 20*log10(abs(Syx_p)));

subplot(212);
plot(f, arg(Syx_p));

