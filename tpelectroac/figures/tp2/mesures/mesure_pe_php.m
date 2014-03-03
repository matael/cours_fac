%
% mesure_php_uhp.m
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

% récupération des données
filename = 'mesure_php-uhp/FRF.txt';
raw_data = CTTM_read_txt(filename, 3);
FRF_php = raw_data(:,2)+j*raw_data(:,3);
freqs = raw_data(:,1);

lim = @() xlim([10 1000]);

filename = 'mesure_pe-uhp/FRF.txt';
raw_data = CTTM_read_txt(filename, 3);
FRF_pe = raw_data(:,2)+j*raw_data(:,3);

filename = 'mesure_php-uhp/Cohérences.txt';
raw_data = CTTM_read_txt(filename, 2);
COH_php = raw_data(:,2);

filename = 'mesure_pe-uhp/Cohérences.txt';
raw_data = CTTM_read_txt(filename, 2);
COH_pe = raw_data(:,2);

% Modules
subplot(311);
hold on;
semilogx(freqs, 20*log10(abs(FRF_php)), 'b');
semilogx(freqs, 20*log10(abs(FRF_pe)), 'r');
plot([89 89], [-60 20], 'k');

xlabel('Frequence');
ylabel('|H|_{dB}');
legend('HP', 'Event');
grid on;
lim();
ylim([-60 20]);

% Phases
subplot(312);
hold on;
semilogx(freqs, arg(FRF_php), 'b');
semilogx(freqs, arg(FRF_pe), 'r');
plot([89 89], [-3.5 3.5], 'k');
xlabel('Frequence');
ylabel('Arg(H)');
grid on;
set(gca, 'ytick', [-pi, -pi/2, 0, pi/2, pi]);
set(gca, 'yticklabel', {'-pi', '-pi/2', '0', 'pi/2', 'pi'});
lim()
ylim([-3.5 3.5]);


subplot(313);
hold on;
semilogx(freqs, COH_php, 'b');
semilogx(freqs, COH_pe, 'r');
xlabel('Frequence');
ylabel('COH(H)');
grid on;
lim()

print('-dpng', 'frf_pe_php.png');

