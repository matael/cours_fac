clear all;
close all;

%
% Les deux derniers tracés du TP
%
% Amplitude des oscillation
% et déphasage bras/pendule
%

name = 'mesures_1';
file = load(name);

% Tracé de l'amplitude
subplot(2,1,1);
plot(file(:,1), file(:,2), '+-');
title('Amplitude, i=1A');
xlabel("Tension en mV");
ylabel("Amplitude du mouvement en graduations");
grid on;

% Tracé de la phase
subplot(2,1,2);
plot(file(:,1), file(:,3), '+-');
title('Phase, i=1A');
xlabel("Tension en mV");
ylabel("Phase en radians");
grid on;

print([name '.png'], '-dPNG');

name = 'mesures_025';
file = load(name);

% Tracé de l'amplitude
subplot(2,1,1);
plot(file(:,1), file(:,2), '+-');
title('Amplitude, i=0.25A');
xlabel("Tension en mV");
ylabel("Amplitude du mouvement en graduations");
grid on;

% Tracé de la phase
subplot(2,1,2);
plot(file(:,1), file(:,3), '+-');
title('Phase, i=0.25A');
xlabel("Tension en mV");
ylabel("Phase en radians");
grid on;

print([name '.png'], '-dPNG');
