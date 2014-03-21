%
% modes_theoriques.m
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

E = 210e9;
eta = 0.285;
rho = 7.8e3;

h = 1.1e-2;
b = 2.5e-2;
l = 82.6e-2;
m = h*l*b*rho;

I = b*h^3/12;

function y = mu(n)
	small_mu = [0, 4.730 7.853];
	if n < 3
		y = small_mu(n);
	else
		y = (2*n-1)*pi/2;
	end
end

for n=(1:6)
	omega = (mu(n))^4*(E*I)/(m*l^4);
	f = sqrt(omega)/(2*pi);
	disp(['freq ' num2str(n) ' : ' num2str(f)])
end
for n=(1:6)
	omega = (mu(n))^4*(E*I)/(m*l^4);
	f = sqrt(omega)/(2*pi);
	disp(['$' num2str(n-1) '$ & $' num2str(f) '$\\'])
end
