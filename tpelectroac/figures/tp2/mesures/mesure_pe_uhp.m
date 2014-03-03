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

filename = 'mesure_pe-uhp/FRF.txt';
raw_data = CTTM_read_txt(filename, 3);

FRF = raw_data(:,2)+j*raw_data(:,3);
freqs = raw_data(:,1);

subplot(311);
semilogx(freqs, 20*log10(abs(FRF)));
xlabel('Frequence');
ylabel('|H|_{dB}');
grid on;

subplot(312);
semilogx(freqs, arg(FRF));
xlabel('Frequence');
ylabel('Arg(H)');
grid on;

filename = 'mesure_pe-uhp/Cohérences.txt';
raw_data = CTTM_read_txt(filename, 2);

COH = raw_data(:,2);
freqs = raw_data(:,1);

subplot(313);
semilogx(freqs, COH);
xlabel('Frequence');
ylabel('COH(H)');
grid on;

print('-dpng', 'frf_php_uhp.png');

