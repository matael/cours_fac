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

function [cell] = celldef(Zc, Zm, S, L, k)
	%
	% celldef(Zc, Ye, d, k)
	%
	% Avec :
	% - Zc : imped caractéristique des tubes
	% - Ye : admittance du diffuseur
	% - d : longueur des tube (conception symétrique)
	% - k : nombre d'onde (peut être un vecteur)

	cell = [
		(sin(k*L*.5)).^2+.5*(cos(k*L)+1)+(j*sin(k*L))./(2*S^2*Zc*Zm), (j*S^2*Zc*Zm*sin(k*L)+.5*(cos(k*L)+1))./(S^2*Zm)
		(j*S^2*Zc*Zm*sin(k*L)+.5*(cos(k*L)-1))./(S^2*Zc^2*Zm), (sin(k*L*.5)).^2+.5*(cos(k*L)+1)+(j*sin(k*L))./(2*S^2*Zc*Zm)
	];
end

