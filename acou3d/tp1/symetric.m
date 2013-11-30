%
% symetric.m
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

function [final_data] = symetric(meas_data)
	final_data = meas_data;

	for i=1:length(meas_data)
		angle = meas_data(i,1);
		value = meas_data(i,2);
		if (angle < pi/2 && angle > 0)
			final_data = [final_data ; pi/2+(pi/2-angle), value];
		elseif (angle > -pi/2 && angle < 0)
			final_data = [final_data ; -pi/2-(pi/2-abs(angle)), value];
		elseif (angle == 0)
			final_data = [final_data ; pi, value];
		end
	end

	final_data = sortrows(final_data, 1);
	final_data = [final_data(length(final_data),:) ; final_data];

end

