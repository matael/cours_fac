%
% geometry.m
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

_x_v = [2 3 4 5 2 3 4 5 2 3 4 5 2 3 4 5 6 6 5 4 3 2 1 1 1 1 1 1 2 3 4 5 6 6 6 6];
_y_v = [5 5 5 5 4 4 4 4 3 3 3 3 2 2 2 2 2 1 1 1 1 1 1 2 3 4 5 6 6 6 6 6 6 5 4 3];

[xx, yy] = meshgrid(_x_v, _y_v);

