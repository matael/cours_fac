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
if fignum > N_vna || fignum < 1
	fignum = input(['Sur quelle figure voulez vous sélectionner ? (1~' num2str(N_vna) ') '])
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

for i=1:N_vna
	figure(i);
	a = axis();
	plot([f_max f_max], [a(3) a(4)], 'r');

	figure(40+2*i);
	a = axis();
	plot([f_max f_max], [a(3) a(4)], 'r');
end

% load grid
geometry;

% create empty data grid
points = zeros(sqrt(N_vna));

for id=1:N_vna
	points(_x_v(id),_y_v(id)) = sign(phase_amps(id_fmax,id))*abs(mod_amps(id_fmax,id));
end

figure;
surf(points);

figure;
subplot(3,1,[1 2]);
imagesc(points);
title(['Frequence f=' num2str(f_max)]);

subplot(3,1,3);
surf(points);

figure;
% interp matrix :
resample = 1000;
[x1,y1] = meshgrid(1:6,1:6);
[x2,y2] = meshgrid(linspace(1,6, resample),linspace(1,6,resample));
interp_points = interp2(1:6,1:6,points,x2,y2,'cubic');

subplot(3,1,[1 2]);
imagesc(x2,y2,interp_points);
title(['Frequence f=' num2str(f_max)]);

subplot(3,1,3);
surf(points);
set(gca(), 'ztick', []);


% symbolisation du point d'excitation/point de choix
% hold on;
% N_excit = 16;
% gh = plot3(ones(1,2)*_x_v(N_excit), ones(1,2)*_y_v(N_excit), axis()(5:6),'r', 'linewidth', 3);

% récupération de l'amortissement moyen

xi = ones(1,N_vna);

for i=1:N_vna
	if mean(real(amps(f_sel(1):f_sel(2),i)))<0
		new_amps =-amps(f_sel(1):f_sel(2),i);
	else
		new_amps =amps(f_sel(1):f_sel(2),i);
	end

	[_, __, Q, ___] = lms_cerc(f_v(f_sel(1):f_sel(2)), new_amps);
	xi(i) = 1./(2*Q);
end


disp('Amortissement moyen :')
ximean = ceiled_mean(xi,.75)


