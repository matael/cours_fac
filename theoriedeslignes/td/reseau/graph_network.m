%
% graph_network.m
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

%clear all;
%close all;

%% saving
%saveimped = 0;
%savetrans = 1;
%
%% network and study props.
%N_cell = 1; % nb de cellules
%fmax = 1e3;

function graph_network(N_cell, fmax, saveimped, savetrans)

	% propriété du fluide
	rho = 1.293;
	c = 343;

	S = 2; % section du guide
	L = .1; % longueur de la dérivation

	% imped caracs
	Zc = rho*c/S; 		% tube

	f = (0:fmax);
	k_v = 2*pi*f/c; % de 0 à 1kHz
	N = length(k_v);

	% Zm
	Zm = @(k) j*k*L/(2*S*rho*c);

	% quadripole en T
	%
	%       Z1             Z2
	%      _____         _____
	% ----+_____+---+---+_____+--+
	%               |           |
	%              +++         +++
	%              | |         | |
	%              | |ZT       | |Za
	%              | |         | |
	%              +++         +++
	%               |           |
	% --------------+-----------+
	%
	% celldef renvoie une matrice de transfert, donc,
	% d'après le guide des guides

	A = ones(1,N);
	B = ones(1,N);
	C = ones(1,N);
	D = ones(1,N);

	for i=1:N
		k = k_v(i);
		zm = Zm(k);
		cell = celldef(Zc, zm, S, L, k);
		cell = cell^N_cell;
		A(i) = cell(1,1);
		B(i) = cell(1,2);
		C(i) = cell(2,1);
		D(i) = cell(2,2);
	end

	% impédance d'entrée
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Z1 = (A-1)./C;
	Z2 = (D-1)./C;
	ZT = 1./C;

	Za = Zc; % terminaison anéchoique

	Ze = Z1 + 1./(1./ZT + 1./(Z2+Za));

	plot(f, 20*log10(abs(Ze)));
	grid on;
	xlabel('Frequence');
	ylabel('|Z_e|_{dB}')

	savestr = ['imped_entree_' num2str(N_cell) 'cell_0_' num2str(fmax) '.png'];
	savestr_mat = ['Ze_' num2str(N_cell) '_' num2str(fmax) '.mat'];
	if saveimped == 1
		print('-dpng', savestr);
		eval([' stuff = Ze;']);
		save(savestr_mat, 'stuff');
		disp(['    IMG: ' savestr]);
		disp(['    MAT: ' savestr_mat]);
	end

	% coef. de transmission
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Tp = 2./(A+B/Zc+Zc*C+D);

	plot(f, 20*log10(abs(Tp)));
	grid on;
	xlabel('Frequence');
	ylabel('|T^+|_{dB}');

	savestr = ['coef_trans_' num2str(N_cell) 'cell_0_' num2str(fmax) '.png'];
	savestr_mat = ['Tp_' num2str(N_cell) '_' num2str(fmax) '.mat'];
	if savetrans == 1
		print('-dpng', savestr);
		eval([' stuff = Tp;']);
		save(savestr_mat, 'stuff');
		disp(['    IMG: ' savestr]);
		disp(['    MAT: ' savestr_mat]);
	end

end
