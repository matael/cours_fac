%
% batch_plot_FRF.m
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

% measurements
meas = {'monopole', 'dipole', 'quadripole'};

for i=1:length(meas)
	% get current meas name
	cur_meas = meas{i};

	% coherency
	data_coh = data_load(['mesures/' cur_meas '/Cohérences.txt'], 2);

	% FRF
	data_frf = data_load(['mesures/' cur_meas '/FRF.txt'], 3);
	frf = data_frf(:,2)+j*data_frf(:,3);

	subplot(311);
	plot(data_coh(:,1), data_coh(:,2));
	grid on;
	ylabel('COH');
	title(cur_meas);

	subplot(312);
	plot(data_frf(:,1), 20*log10(abs(frf)));
	grid on;
	ylabel('|FRF|_{dB}');

	subplot(313);
	plot(data_frf(:,1), arg(frf));
	grid on;
	title('Reponse en frequence');
	xlabel('Frequence (Hz)');
	ylabel('arg(FRF)');

	print('-dpng', ['coh_frf_' cur_meas '.png']);
end


