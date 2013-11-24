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

V0prev = P0/(rho*c);

figure(1);
plot(F,P0);
grid on;
title('Pression en 0');

figure(2);
plot(F,V0);
grid on;
title('Vitesse en 0');

figure(4);
[AX, H1, H2] = plotyy(F, P0, F, V0, @plot);
xlabel("Frequence (Hz)");
set(AX,{'ycolor'},{'b';'r'});
set(H1,{'color'},{'b'});
set(H2,{'color'},{'r'});
set(AX,{'ycolor'},{'b';'r'});
grid on;
title("Pression et vitesse mesurees en O");
legend("pression", "vitesse");

print('-dpng', 'pression_vitesses_enO.png');


figure(3);
plot(F,V0);
hold on;
plot(F, V0prev, 'r');
grid on;
legend("v_0", "Zp_0");
title("Vitesses mesuree et previsionnelle en O");
xlabel("Frequence (Hz)");
ylabel("Vitesse");
print('-dpng', 'comp_vitesse_prev_mesure.png');
