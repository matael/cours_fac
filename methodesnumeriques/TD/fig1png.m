%
% 1png.m
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

x = (-1:0.0001:2);
y = x.^3+x-1;
y2 = x.^3+x;
plot(x,y,'r');
hold on;
plot(x,y2, 'b');
grid
plot([-1, 2], [1,1], 'k');
plot([-1, 2], [0,0], 'k');

xlim([-.5, 1.5]);
ylim([-1,2]);

print('-dpng', '1.png');


