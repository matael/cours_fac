%
% pressure_speed_fromfile.m
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

function [f, p0, v0] = pv_fromfile(filename)

	fid = fopen(filename);
	% on vire la ligne d'en-tête
	fgetl(fid);

	cols = 5;
	% création de la chaine de formattage
	format = '%e';
	i = 1;
	while i<cols
		format = [format ' %e'];
		i = i+1;
	end

	data = fscanf(fid, format, [cols Inf]);

	fclose(fid);

	data = data';

	% known
	rho = 1.293;
	Dx = 1e-2;

	f = data(:,1);
	p1 = data(:,2)+j*data(:,3);
	p2 = data(:,4)+j*data(:,5);
	p0 = (p1+p2)/2;
	v0 = (p1-p2)./(j*2*pi*f*rho*Dx);
end


