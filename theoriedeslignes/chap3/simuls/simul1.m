%
% simul1.m
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

% célérité du son / masse volumique de l'air
rho0 = 1.293;
c0 = 343;

Zc = rho0*c0;

% section du tube
S = 1;
% longueur de l'élément considéré
l = 1;

% fréquences
f = linspace(0,1e4,1000);
% pulsation
w = 2*pi*f;
% nombre d'onde
k = w/c0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% impédance masse
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Li = rho0/S*w;

Z_masse = j*(Li.*w+Zc*tan(k*l))./(1-Li.*w/Zc.*tan(k*l));

% module/phase
figure(1);
subplot(211);
plot(f,20*log10(abs(Z_masse)));
xlabel('Frequence f');
ylabel('|Z_{masse}|_{dB}');
grid on;

title("Cas d'une masse");

subplot(212);
plot(f,arg(Z_masse));
xlabel('Frequence f');
ylabel('\Theta(Z_{masse})');
grid on;

% Nyquist
figure(2);
plot3(f,real(Z_masse),imag(Z_masse));
xlabel('Frequence f');
ylabel('\Re(Z_{masse})');
zlabel('\Im(Z_{masse})');
title("Cas d'une masse");

% Im/Re
figure(3);
hold on;
plot(f,real(Z_masse),'b');
plot(f,imag(Z_masse),'r');
grid on;
xlabel('Frequence f');
legend('\Re(Z_{masse})', '\Im(Z_{masse})');
title("Cas d'une masse");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% impédance ressort
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V = 10;
Ci = V/(rho0*c0^2);

Z_ressort = j*(Zc*tan(k*l) - 1./(Ci*w))./(1+tan(k*l)./(Ci*w*Zc));

% module/phase
figure(4);
subplot(211);
plot(f,20*log10(abs(Z_ressort)));
xlabel('Frequence f');
ylabel('|Z_{ressort}|_{dB}');
grid on;

title("Cas d'un ressort");

subplot(212);
plot(f,arg(Z_ressort));
xlabel('Frequence f');
ylabel('\Theta(Z_{ressort})');
grid on;

% Nyquist
figure(5);
plot3(f,real(Z_ressort),imag(Z_ressort));
xlabel('Frequence f');
ylabel('\Re(Z_{ressort})');
zlabel('\Im(Z_{ressort})');
title("Cas d'un ressort");

% Im/Re
figure(6);
hold on;
plot(f,real(Z_ressort),'b');
plot(f,imag(Z_ressort),'r');
grid on;
xlabel('Frequence f');
legend('\Re(Z_{ressort})', '\Im(Z_{ressort})');
title("Cas d'un ressort");
