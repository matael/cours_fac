clear all;
close all;

Ntfd = 8192;
Fe = 44100;

file = wavread("countdown1.wav");

subplot(2,1,1);
plot(file);

spectre = fft(file, Ntfd);
freqs = (0:(Ntfd-1))*(Fe/Ntfd);

subplot(2,1,2);
semilogy(freqs, 20*log10(abs(spectre)));
grid on;
xlim([0 Fe/2]);

print("countdown_female.png", "-dPNG");
