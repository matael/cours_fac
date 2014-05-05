%
% plot_all.m
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

clear all;
close all;

N_cell_v = [1 3 9 27];
fmax_v = [1e3 5e3];

saveimped = 0;
savetrans = 1;

for N_cell=N_cell_v
	disp(['+ N_cell=' num2str(N_cell)]);
	for fmax=fmax_v
		disp(['    -> fmax=' num2str(fmax)]);
		graph_network(N_cell, fmax, saveimped, savetrans);
	end
end



