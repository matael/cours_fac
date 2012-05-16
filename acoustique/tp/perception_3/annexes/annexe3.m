clear all;
close all;

data_ok = load("data_oreille_droite_elliot.data");
freqs = data_ok(:,1);
seuils1 = data_ok(:,2);
plot(freqs, seuils1, 'k+-');

hold on;

data_b = load("data_oreille_droite_elliot_bouchon.data");
freqs = data_b(:,1);
seuils2 = data_b(:,2);
plot(freqs, seuils2, 'b+-');

diff = seuils2 - seuils1;
plot(freqs, diff, 'r+-');

title("Audiogrammes de la meme oreille, obstruee ou non");
ylabel("Seuil d'audition en dB");
xlabel("Frequence en Hz");
legend("Oreille Droite", "Oreille Droite Bouche", "Difference");

ylim([-15 50]);
grid on;

print("annexe_3_raw.png", "-dPNG");

