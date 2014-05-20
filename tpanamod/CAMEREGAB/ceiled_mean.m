%
% ceiled_mean.m
%
% Copyright (C) 2014 Mathieu Gaborit (matael) <mathieu@matael.org>
%
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

function [x_mean] = ceiled_mean(x, max_diff)
	%
	% [x_mean] = ceiled_mean(x, max_diff)

	% check if vector is 1D
	if size(x)(1) != 1 && size(x)(2) != 1
		disp('x must be 1D vctor');
		return;
	end

	if length(x) == 1
		x_mean = x;
		return;
	end

	% first sort the vector
	x = sort(x);

	new_x = [x(1)];
	for i=2:length(x)
		if ((x(i) - x(i-1))/x(i-1) <= max_diff)
			new_x = [new_x x(i)];
		end
		break;
	end

	x_mean = mean(new_x);
end
