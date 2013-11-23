clear all
close all

rho = 1.293;
c = 343;

a = load('./mesure_1/FRF.txt');
Re_c1 = a(:,2);
Im_c1 = a(:,3);
Re_c2 = a(:,4);
Im_c2 = a(:,5);
F = a(:,1);
k = 2* pi * F / c;


P1 = Re_c1 + i * Im_c1;
P2 = Re_c2 + i*Im_c2;

P0 = ( P1 + P2 ) ./ (2*cos(k/2 *10^-2));
V0 = (P1 - P2) ./ (i*2*rho*c*sin(k*10^-2/2));

V0prev = rho*c*P0;
% rectification du drift temporel
[m, id_v0] = max(V0);
[m, id_V0prev] = max(V0prev);
drift = id_v0 -  id_V0prev
if (drift > 0)
	V0prev = [zeros(abs(drift),1) ; V0prev(1:end-abs(drift))];
elseif (drift < 0)
	V0prev = [V0prev(abs(drift)+1:end) ; zeros(abs(drift),1)];
	length(V0prev)
	length(F)
end

figure(1);
plot(F,P0);
grid on;
title('Pression en 0');

figure(2);
plot(F,V0);
grid on;
title('Vitesse en 0');

figure(3);
plot(F,V0/max(V0));
hold on;
plot(F, V0prev/max(V0prev), 'r');
grid on;
legend("v_0", "Zp_0");
title("Vitesses mesuree et previsionnelle en O (apres normalisation a 1)");
xlabel("Frequence (Hz)");
ylabel("Vitesse (normalisee)");
