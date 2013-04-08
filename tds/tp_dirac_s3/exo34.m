clear all;
close all;

Ntfd = 2048;

% Config
Ncycle = 4;
Fe = 1000;
Nburst = 1;
Fburst = 2;
F0 = 100;

[t,s]=toneburst(Ncycle,Nburst,Fburst,Fe,F0);

% Spectre
spectre = fft(s, Ntfd);
freqs = (0:(Ntfd-1))*(Fe/Ntfd);

subplot(2,1,1);
plot(t, s);
title("Signal temporel");

subplot(2,1,2);
plot(freqs, 20*log10(abs(spectre)), '+');


