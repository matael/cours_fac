clear all;
close all;

hold on;
data_current = load("data_oreille_droite_erwan.data");
freqs = data_current(:,1);
seuils = data_current(:,2);
plot(freqs, seuils, 'r+-');
	
data_current = load("data_oreille_gauche_mathieu.data");
freqs = data_current(:,1);
seuils = data_current(:,2);
plot(freqs, seuils, 'k+-');
	
data_current = load("data_oreille_droite_elliot.data");
freqs = data_current(:,1);
seuils = data_current(:,2);
plot(freqs, seuils, 'b+-');
	
data_current = load("data_oreille_gauche_elliot.data");
freqs = data_current(:,1);
seuils = data_current(:,2);
plot(freqs, seuils, 'g+-');

title("Audiogrammes de 4 oreilles");
ylabel("Seuil d'audition en dB");
xlabel("Frequence en Hz");
legend("Oreille Droite Erwan", "Oreille Gauche Mathieu", "Oreille Droite Elliot", "Oreille Gauche Elliot");
box on;
grid on;

xlim([0 9000]);
ylim([-15 35]);

print("annexe_1_raw.png", "-dPNG");

