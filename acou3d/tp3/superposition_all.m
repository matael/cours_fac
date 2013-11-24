%
% superposition_all.m
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

mesures = { '3'; '4' };
angles = {{'0','0'},{'2','pi/2'}, {'4','pi/4'}};
for i=1:length(mesures)
	mesure = mesures{i};
	for j=1:length(angles)
		angle = angles{j};
		close all;
		superposition(mesure, angle{1}, angle{2});
	end
end
clear all;
close all;
