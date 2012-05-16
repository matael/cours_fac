clear all;
close all;

data_ok = load("data_oreille_droite_elliot.data");
freqs = data_ok(:,1);
seuils = data_ok(:,2);
plot(freqs, seuils, 'r');

hold on;

data_b = load("data_oreille_droite_elliot_bouchon.data");
freqs = data_b(:,1);
seuils = data_b(:,2);
plot(freqs, seuils, 'k');

title("Audiogramme");
ylabel("Seuil d'audition en dB");
xlabel("Frequence");
legend("Oreille Droite", "Oreille Droite Bouche");
grid on;

