%
% sim2_R.m
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

rho1 = 1.293;
c1 = 343;
rho2 = 1000;
c2 = 1480;

Z1 = rho1*c1;
Z2 = rho2*c2;

Npoints = 100;

% theta 1
t1 = (0:pi/(2*Npoints):pi/2);
% theta 2
t2 = asin(c2/c1.*sin(t1));

R = ((cos(t1)/Z1-cos(t2)/Z2))./((cos(t1)/Z1+cos(t2)/Z2));
L = (cos(t1).*cos(t2)*4/(Z1*Z2))./((cos(t1)/Z1+cos(t2)/Z2).^2);

figure(1);
plot(t1,R);
title("R");
figure(2);
plot(t1,L);
title("T");
