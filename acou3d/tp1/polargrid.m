%
% polargrid.m
%
% Copyright (C) 2011 Bruno B
%

function polargrid

	ax = axis();
	rmax = max(abs(ax(1:4)));
	grid off


	hold on
	% on trace les 36 droites : tous les 10 degrés
	for angle = linspace(0,2*pi,37)
		polar([angle angle],[0 rmax],'k')
	end

	% on trace les 9 cercles
	un = ones(1,180);
	t = linspace(0,2*pi,180);
	for rayon=linspace(rmax/9,rmax,9)
		polar(t,rayon*un,'k')
	end

	hold off
	axis('square')

end


