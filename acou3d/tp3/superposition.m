%
% superposition.m
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

function superposition(mesure, angle, angle_titre)

	% source 1
	[f,p0_1,v0_1] = pv_fromfile(['./mesure' mesure '_s1_' angle '/FRF.txt']);

	% source 2
	[f,p0_2,v0_2] = pv_fromfile(['./mesure' mesure '_s2_' angle '/FRF.txt']);


	% source 2
	[f,p0_12,v0_12] = pv_fromfile(['./mesure' mesure '_s1s2_' angle '/FRF.txt']);

	% p0 s1, s2, s1+s2
	figure(1);
	plot(f, p0_1);
	hold on;
	plot(f, p0_2, 'k');
	plot(f, p0_1+p0_2, 'r');
	xlabel("freqence (hz)");
	legend("p_{01}", "p_{02}", "p_{01}+p_{02}");
	title(['Pression avec la source 1, 2 puis somme en 0 ; theta = ' angle_titre]);
	grid on;

	print('-dpng', ['mesure_' mesure 'pression_s1_s2_s1ps2_' angle '.png']);


	% p0 s1+s2, s1s2
	figure(2);
	plot(f, p0_1+p0_2,'r');
	hold on;
	plot(f, p0_12, 'b');
	xlabel("freqence (hz)");
	legend("p_{01}+p_{02}", "p_{01+2}");
	title(['Somme des pressions pour chacune des sources puis pression mesuree avec 2 sources ; theta = ' angle_titre]);
	grid on;

	print('-dpng', ['mesure_' mesure 'pression_s1ps2_s1s2_' angle '.png']);


	% v0 s1, s2, s1+s2
	figure(3);
	plot(f, v0_1);
	hold on;
	plot(f, v0_2, 'k');
	plot(f, v0_1+v0_2, 'r');
	xlabel("freqence (hz)");
	legend("v_{01}", "v_{02}", "v_{01}+v_{02}");
	title(['Vitesse avec la source 1, 2 puis somme en 0 ; theta = ' angle_titre]);
	grid on;

	print('-dpng', ['mesure_' mesure 'vitesse_s1_s2_s1ps2_' angle '.png']);


	% v0 s1+s2, s1s2
	figure(4);
	plot(f, v0_1+v0_2, 'r');
	hold on;
	plot(f, v0_12, 'b');
	xlabel("freqence (hz)");
	legend("v_{01}+v_{02}", "v_{01+2}");
	title(['Somme des vitesses pour chacune des sources puis vitesse mesuree avec 2 sources ; theta = ' angle_titre]);
	grid on;

	print('-dpng', ['mesure_' mesure 'vitesse_s1ps2_s1s2_' angle '.png']);

end
