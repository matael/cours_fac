%
% directiv_1source.m
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

data = load('data_2k.data');

angles = data(:,1)*pi;
re1 = data(:,3);
im1 = data(:,4);
re2 = data(:,5);
im2 = data(:,6);

p1 = abs(re1+j*im1);
p2 = abs(re2+j*im2);

p0 = (p1+p2)/2;

polar(angles, 20*log10(p0/2e-5), '+');
figure(2);
stem(angles/pi, p0);

