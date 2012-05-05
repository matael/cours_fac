clear all;
close all;

t = (0:0.001:1);

p1 = 10*sin(2*pi*t);

p3 = (10/3)*sin(6*pi*t);

ptot = p1+p3;

subplot(2,1,1);
plot(t,p1, 'r');
hold on;
plot(t,p3, 'b');
hold on;
plot(t, ptot, 'g');
grid on;
legend("p1","p3","somme");
title("Somme des signaux");
hold off;

subplot(2,1,2);
f = (0:1000);
spec = abs(fft(ptot));
plot(f, spec);
xlim([0 20]);
title("Transformee de la somme");

print("annexe2.png", '-dPNG');
