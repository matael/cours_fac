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

L = .5;
S = 1;

Z = rho*c/S;

fmax = 1e3;
N_echant = 1e4;
f_v = linspace(1,fmax,N_echant);
k_v = 2*pi*f_v/c;
cosgammaL = cos(k_v*L) + sin(k_v*L)/(k_v*L);

figure(1);
plot(k_v*L, cosgammaL);
xlabel('kL');
ylabel('cos(\Gamma L)');
grid on;

print('-dpng', 'dispersion.png')

figure(2);

subplot(121);
plot(real(acos(cosgammaL)), k_v*L);
xlabel('\Re(\Gamma L)');
ylabel('kL');
grid on;

subplot(122);
plot(imag(acos(cosgammaL)), k_v*L);
xlabel('\Im(\Gamma L)');
ylabel('kL');
grid on;

print('-dpng', 're_im_gammaL.png')


