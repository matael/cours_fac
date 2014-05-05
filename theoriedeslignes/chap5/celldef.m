%
% celldef.m
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

% définition d'une cellule.

function [cell] = celldef(Zc, Ye, d, k)
	%
	% celldef(Zc, Ye, d, k)
	%
	% Avec :
	% - Zc : imped caractéristique des tubes
	% - Ye : admittance du diffuseur
	% - d : longueur des tube (conception symétrique)
	% - k : nombre d'onde (peut être un vecteur)

	cell = [
		j.*.5.*Ye.*Zc.*sin(d.*k)+cos(d.*k), .5.*Ye.*Zc^2.*(cos(k.*d)-1)+j.*Zc.*sin(d.*k); 	% A,B
		.5.*Ye.*(cos(k.*d)+1)+j/Zc.*sin(d.*k), j.*.5.*Ye.*Zc.*sin(d.*k)+cos(d.*k)			% C,D
	];
end


