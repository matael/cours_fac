clear all;
close all;

Ntfd = 8192;
Fe = 44100;

file = wavread("countdown2.wav");

seq = [];
from=1;
to=37000;
for i=(from:to)
	seq = [seq file(i)];
endfor

subplot(2,1,1);
plot(seq);
title("Ten Male");

spectre = fft(seq, Ntfd);
freqs = (0:(Ntfd-1))*(Fe/Ntfd);

subplot(2,1,2);
semilogy(freqs, abs(spectre));
grid on;
xlim([0 Fe/2]);


print("ten_male.png", "-dPNG");
