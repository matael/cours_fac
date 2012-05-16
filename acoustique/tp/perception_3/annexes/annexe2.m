clear all;
close all;

data = load("data_mastoide_droite_thomas.data");
freqs = data(:,1);
seuils = data(:,2);
plot(freqs, seuils, 'r+-');

title("Audiogramme pour la mastoide droite de Thomas");
ylabel("Seuil d'audition en dB");
xlabel("Frequence en Hz");
legend("Mastoide Droite Thomas");

xlim([0 5000]);
grid on;

print("annexe_2_raw.png", "-dPNG");
