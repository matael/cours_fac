%
% data_load.m
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

function data = data_load(filename, cols)

	if cols<1
		disp('cols must greater than 1 or equal');
	end

	fid = fopen(filename);
	% on vire la ligne d'en-tête
	fgetl(fid);

	% création de la chaine de formattage
	format = '%e';
	i = 1;
	while i<cols
		format = [format ' %e'];
		i = i+1;
	end

	data = fscanf(fid, format, [cols Inf]);

	data = data';

end
