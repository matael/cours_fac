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

% [f, Sm1, Sm2] = interspec_fromfile('mesure4_s1s2_2/Gxy.txt');
% 
% % revonstruct pressure cross-spectrum
% Syx_p = (Sm1+Sm2) / (2);
% 
% subplot(211);
% plot(f, 20*log10(abs(Syx_p)));
% 
% subplot(212);
% plot(f, unwrap(arg(Syx_p)));

autospectres = data_load('mesure4_s1s2_2/Autospectres.txt', 4);
Syy = autospectres(:,3);
Sxx = autospectres(:,2);
frfs = data_load('mesure4_s1s2_0/FRF.txt',5);
H1 = frfs(:,2)+j*frfs(:,3);

figure(1);
semilogy(autospectres(:,1), sqrt(H1));

figure(2);
plot(autospectres(:,1), unwrap(angle(H1)));

