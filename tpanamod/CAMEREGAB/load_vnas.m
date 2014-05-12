%
% load_vnas.m
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

function [freqs,amps] = load_vnas(varargin)
	%
	% [freqs, amps] = load_vnas(n, col [, folder])
	%
	% n : nombre de vnas à charger
	% col : colonne d'amplitude à extraire du vna
	% folder : (opt.) dossier de stockage des vnas
	%
	% OUT
	%
	% freqs : vecteur de frequences
	% amps : matrice (length(freqs)xn) des ampitudes

	if length(varargin) == 2
		n = varargin{1};
		xcmeasn = varargin{2};
		folder = '.';
	elseif length(varargin) >= 3
		n = varargin{1};
		xcmeasn = varargin{2};
		folder = varargin{3};
	else
		disp('Please use at least 2 parameters');
	end

	amps = [];
	freqs = [];
	for i=(1:n)

		% loading vna
		vna = load([folder '/' num2str(i) '.vna']);

		% check if all frequencies axis are the same
		if i==1
			freqs = vna.SLm.fdxvec;
		elseif vna.SLm.fdxvec != freqs
			exit(['All VNAs do not have the same f vector. Check ' folder '/' str2num(1) '.vna']);
		end

		amps = [amps , vna.SLm.xcmeas(xcmeasn).xfer];
	end
end


