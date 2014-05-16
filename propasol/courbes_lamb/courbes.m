%
% plan_kxh_fh.m
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

% on cherche à tracer les courbes pour les modes sym et antisym
% d'après les éq de propagation dans une plaque solide.
%
% Les valeurs ne sont pas demandées, uniquement les courbes.
% On procède ainsi :
%
% via 2 vecteurs et un meshgrid, on crée le plan (kxh,fh)
% on trace ensuite les surfaces données par les deux
% 	membres du déterminant de la matrice.


h = input('Epaisseur de la plaque : ');

% Vref fluide
Vfluide = 1.48;

% vecteur f
f0 = 0;
f1 = 10;
fpas = 0.02;
f_v = (f0:fpas:f1);

% vecteur kx
%kx0 = 0;
%kx1 = 10;
%kx_pas = .1;
%kx_v = (kx0:kx_pas:kx1);
kx_v = 2*pi*f_v/Vfluide;

[kx, f]= meshgrid(kx_v, f_v);
w = 2*pi*f;

% célérités (mm/µs)
vL = 5.630;
vT = 2.958;

% nombres d'ondes kivonbien
kL = w/vL;
kT = w/vT;

% projetés en z
kzL = sqrt(kL.^2 - kx.^2);
kzT = sqrt(kT.^2 - kx.^2);

d = .5*h;
% plan de trace
sym = 4.*kx.^2.*kzL.*kzT.*cos(kzL*d).*sin(kzT*d)+(2*kx.^2-kT.^2).^2.*cos(kzT*d).*sin(kzL*d);
antisym = 4.*kx.^2.*kzL.*kzT.*sin(kzL*d).*cos(kzT*d)+(2*kx.^2-kT.^2).^2.*sin(kzT*d).*cos(kzL*d);

sym = real(sym) + imag(sym);
antisym = real(antisym) + imag(antisym);

isoline = [0 0];

% figure : plan kxh,fh
figure;
contour(kx*h, f*h, sym, isoline, 'b');
hold on;
contour(kx*h, f*h, antisym, isoline, 'r');

% tracé des VL et VT
plot(f_v*h,kx_v, w.*kx_v, 'g--');
plot(f_v*h,kx_v, w.*kx_v, 'g--');

xlabel('k_x.h');
ylabel('f.h');

ylim([0 10]);
xlim([0 10]);

grid on;

% figure : plan fh,vphi
figure;

vphi = w./kx;
contour(f*h, vphi, sym, isoline, 'b');
hold on;
contour(f*h, vphi, antisym, isoline, 'r');

xlabel('f.h');
ylabel('v_\Phi');

% tracé des VL et VT
% TODO
plot(f_v*h,vphi, ones(), 'g--');
plot(f_v*h,vphi, w./kT, 'g--');

xlim([0 10]);
ylim([0 15]);

grid on;

% figure : plan fh,theta_inc
figure;

theta = real(asin(kx/max(max(kx))./w*Vfluide));
contour(f*h, theta, sym, isoline, 'b');
hold on;
contour(f*h, theta, antisym, isoline, 'r');

% tracé des VL et VT
plot(f_v*h, theta, ones(length(f_v),1)*Vfluide/VL, 'g--');
plot(f_v*h, theta, ones(length(f_v),1)*Vfluide/VL, 'g--');

xlabel('f.h');
ylabel('\theta^{inc}');

xlim([0 10]);
ylim([0 0.02]);

grid on;
