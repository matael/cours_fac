clear all;
close all;

data = load("data_mastoide_droite_thomas.data");
freqs = data(:,1);
seuils = data(:,2);
plot(freqs, seuils, 'r');

title("Audiogramme");
ylabel("Seuil d'audition en dB");
xlabel("Frequence");
legend("Mastoide Droite Thomas");

xlim([0 8000]);
grid on;

