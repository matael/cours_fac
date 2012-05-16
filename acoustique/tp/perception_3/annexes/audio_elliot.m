clear all;
close all;

data_ok = load("data_oreille_droite_elliot.data");
freqs = data_ok(:,1);
seuils = data_ok(:,2);
plot(freqs, seuils, 'r');

hold on;

data_ok = load("data_oreille_gauche_elliot.data");
freqs = data_ok(:,1);
seuils = data_ok(:,2);
plot(freqs, seuils, 'b');


title("Audiogramme");
ylabel("Seuil d'audition en dB");
xlabel("Frequence");
legend("Oreille Droite", "Oreille Gauche");
grid on;

