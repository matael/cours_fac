%
% tf_hpbafle.m
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

A = 1;
fc = 90; % Hz
wc = 2*pi*fc;
Q = [0.5 1 2];
w = 2*pi*linspace(1, 20000, 2500);

figure(1);

couleurs = hsv(4);

for i=1:length(Q)
	q = Q(i);
	tf = A*((j*w/wc).^2)./(ones(1,length(w))+j*1/q*w./wc+(j*w/wc).^2);
	subplot(211);
	hold on;
 	semilogx(w, 20*log10(abs(tf)), 'color', couleurs(i,:));
	subplot(212);
	hold on;
	semilogx(w, arg(tf), 'color', couleurs(i,:));
end

subplot(211);
xlabel('Pulsation');
ylabel('|H|_{dB}');
legend('Q = 0.5', 'Q = 1', 'Q = 2');
grid on;

subplot(212);
xlabel('Pulsation');
ylabel('Arg(H)');
set (gca, 'ytick', [-pi -pi/2 0 pi/2 pi]);
set (gca, 'yticklabel', {'-pi' '-pi/2' '0' 'pi/2' 'pi'});
grid on;

print('-dpng', 'tf_hpbafle.png');
