clear all;
close all;

data_erwan_od = load("data_oreille_droite_erwan.data");
freqs = data_erwan_od(:,1);
seuils = data_erwan_od(:,2);
plot(freqs, seuils, 'r');

hold on;

data_mathieu_og = load("data_oreille_gauche_mathieu.data");
freqs = data_mathieu_og(:,1);
seuils = data_mathieu_og(:,2);
plot(freqs, seuils, 'k');

title("Audiogramme");
ylabel("Seuil d'audition en dB");
xlabel("Frequence");
legend("Oreille Droite Erwan", "Oreille Gauche Mathieu");
grid on;

