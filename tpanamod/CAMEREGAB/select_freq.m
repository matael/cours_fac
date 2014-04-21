%
% select_freq.m
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

fignum = 0;
if fignum > 16 || fignum < 1
	fignum = input('Sur quelle figure voulez vous sélectionner ? (1~16) ')
end
figure(fignum);
disp('Encadrez un pic entre deux points de sélection');
[x,y] = ginput(2);

% extraction des fréquences encadrantes réelles
df = max(f_v)/length(f_v);
f_sel = [0 0];
for i=[1,2]
	crible = (f_v <= x(i)+0.5*df) &(f_v >= x(i)-0.5*df);
	[m,idm] = max(crible);
	f_sel(i) = idm;
end

% frequence du max de la bande
[m, idm] = max(mod_amps(f_sel(1):f_sel(2),fignum));
id_fmax = idm+f_sel(1);
f_max = f_v(id_fmax)

for i=1:16
	figure(i);
	a = axis();
	plot([f_max f_max], [a(3) a(4)], 'r');

	figure(30+2*i);
	a = axis();
	plot([f_max f_max], [a(3) a(4)], 'r');
end

[xx,yy] = meshgrid(0:3,0:3);

points = zeros(4);

for i=1:length(points)
	for j=1:length(points(i,:))
		id = (i-1)*4+j;
		points(i,j) = sign(phase_amps(id_fmax,id))*abs(mod_amps(id_fmax,id));
	end
end

figure;
surf(xx,yy,points);




