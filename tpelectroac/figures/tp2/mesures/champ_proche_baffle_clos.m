%
% champ_proche_baffle_clos.m
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

clear all;
close all;

filename = 'champ_proche_baffle_clos/FRF.txt';
raw_data = CTTM_read_txt(filename, 3);

FRF = raw_data(:,2)+j*raw_data(:,3);
freqs = raw_data(:,1);

limiter = [30 max(freqs)];

subplot(311);
semilogx(freqs, 20*log10(abs(FRF)));
hold on;
plot([74 74],[0 40], 'k');
xlabel('Frequence');
ylabel('|H|_{dB}');
grid on;
xlim(limiter);
ylim([0 40])

subplot(312);
semilogx(freqs, arg(FRF));
hold on;
plot([74 74],[-pi pi], 'k');
xlabel('Frequence');
ylabel('Arg(H)');
grid on;
xlim(limiter);
ylim([-pi pi]);
set(gca, 'ytick', [-pi, -pi/2, 0, pi/2, pi]);
set(gca, 'yticklabel', {'-pi', '-pi/2', '0', 'pi/2', 'pi'});

filename = 'champ_proche_baffle_clos/Cohérences.txt';
raw_data = CTTM_read_txt(filename, 2);

COH = raw_data(:,2);
freqs = raw_data(:,1);

subplot(313);
semilogx(freqs, COH);
xlabel('Frequence');
ylabel('COH(H)');
grid on;
xlim(limiter);

print('-dpng', 'frf_clos.png');
