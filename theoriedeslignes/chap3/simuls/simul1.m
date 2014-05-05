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
f = linspace(0,1e3,1000);
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
hold on;
plot(f,20*log10(abs(Z_masse)),'r');
xlabel('Frequence f');
ylabel('|Z|_{dB}');
grid on;

subplot(212);
hold on;
plot(f,arg(Z_masse),'r');
xlabel('Frequence f');
ylabel('\Theta(Z)');
grid on;

% Im/Re
figure(2);
subplot(211);
hold on;
plot(f,real(Z_masse),'r');
grid on;
xlabel('Frequence f');
ylabel('\Re');

subplot(212);
hold on;
plot(f,imag(Z_masse),'r');
grid on;
xlabel('Frequence f');
ylabel('\Im');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% impédance ressort
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V = 10;
Ci = V/(rho0*c0^2);

Z_ressort = j*(Zc*tan(k*l) - 1./(Ci*w))./(1+tan(k*l)./(Ci*w*Zc));

% module/phase
figure(1);
subplot(211);
plot(f,20*log10(abs(Z_ressort)),'k');

subplot(212);
plot(f,arg(Z_ressort),'k');

% Im/Re
figure(2);
subplot(211);
hold on;
plot(f,real(Z_ressort),'k');

subplot(212);
hold on;
plot(f,imag(Z_ressort),'k');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% résistance pure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


X = j*w;
Z_res = j*(X+Zc*tan(k*l))./(1+X/Zc.*tan(k*l));


% module/phase
figure(1);
subplot(211);
plot(f,20*log10(abs(Z_res)),'b');

subplot(212);
plot(f,arg(Z_res),'b');

% Im/Re
figure(2);
subplot(211);
hold on;
plot(f,real(Z_res),'b');

subplot(212);
hold on;
plot(f,imag(Z_res),'b');

figure(1);
legend('Masse', 'Ressort', 'Resistance');
print('-dpng','figure1.png');
figure(2);
legend('Masse', 'Ressort', 'Resistance');
print('-dpng','figure2.png');
