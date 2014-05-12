%
% disper.m
%
% Copyright (C) 2014 Mathieu Gaborit (matael) <mathieu@matael.org>
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

c = 343;
rho = 1.293;

S = 1;
s = .5;
d = .2;
l = .1;

Z = rho*c/S;
Zderiv = rho*c/s;

fmax = 5e3;
N_echant = 1e4;
f_v = linspace(1,fmax,N_echant);
k_v = 2*pi*f_v/c;

cosgammad = cos(k_v*d) - Z/Zderiv * tan(k_v*l)/2.*sin(k_v*d);

figure(1);
plot(k_v*d, cosgammad);
xlabel('kd');
ylabel('cos(\Gamma d)');
grid on;

print('-dpng', 'dispersion.png')

figure(2);

subplot(121);
plot(real(acos(cosgammad)), k_v*d);
xlabel('\Re(\Gamma d)');
ylabel('kd');
grid on;

subplot(122);
plot(imag(acos(cosgammad)), k_v*d);
xlabel('\Im(\Gamma d)');
ylabel('kd');
grid on;

print('-dpng', 're_im_gammad.png')


