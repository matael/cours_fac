%
% vitesse_max_mesure3.m
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

angles = {"0","4","2"};

for mes=[3,4]
	disp(['Mesure ' num2str(mes)]);
	figure(mes-2);
	hold on;
	for i=1:length(angles)
		angle = angles{i};
		disp(['    Angle ' angle]);
		[F, p0, v0] = pv_fromfile(['mesure' num2str(mes) '_s1s2_' angle '/FRF.txt']);
		disp(['Vitesse moyenne : ' num2str(abs(mean(v0)))]);

		plot(F, v0, num2str(i));
	end

	title('Vitesses pour 3 angles');
	legend("0", "pi/4", "pi/2");
	grid on;
	print('-dpng', ['mesure' num2str(mes) 'vitesse_3angles.png']);
end
