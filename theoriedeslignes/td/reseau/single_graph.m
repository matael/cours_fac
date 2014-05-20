%
% single_graph.m
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
clear all;
close all;

colors = {'g','r','b','k'};

offset = 0;
for fmax=[1000,5000]

	f_v = 0:fmax;

	cellcounter = 1;
	for N_cell=[27,9,3,1]

		typecounter = 1;
		for type={'Ze','Tp'}
			stuff = load([type{1} '_' num2str(N_cell) '_' num2str(fmax) '.mat']);
			stuff = stuff.stuff; % unpack
			figure(offset+typecounter);
			hold on;
			plot(f_v, 20*log10(abs(stuff)), colors(cellcounter));
		typecounter = typecounter+1;
		end
		cellcounter = cellcounter+1;
	end
	offset = offset + 2;
end


for i=1:4

	if (mod(i,2) == 0)
		graph_type = 'Tp';
	else
		graph_type = 'Ze';
		ylim([-300 50]);
	end

	if (i > 2)
		fmax = '5000';
	else
		fmax = '1000';
	end


	figure(i);
	grid on;
	xlabel('Frequence');
	ylabel(['|' graph_type '|_{dB}']);
	legend('27 cellules','9 cellules','3 cellules','1 cellule', 'location', 'southwest');


	print('-dpng', [graph_type '_' fmax '.png']);
end
