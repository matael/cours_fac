clear all;
close all;


% axe des temps
t = linspace(0, 10, 500);

a = 5; % amplitude
f = 100;

% signal 1;
s1 = a*sin(2*pi*f*t);

subplot(4,1,1);
i = 1;
s2 = a*sin(2*pi*(f+i)*t);
plot(t, s1+s2, ["b;df=" num2str(i) ";"]);

subplot(4,1,2);
i = 10;
s2 = a*sin(2*pi*(f+i)*t);
plot(t, s1+s2, ["b;df=" num2str(i) ";"]);

subplot(4,1,3);
i = 25;
s2 = a*sin(2*pi*(f+i)*t);
plot(t, s1+s2, ["b;df=" num2str(i) ";"]);

subplot(4,1,4);
i = 50;
s2 = a*sin(2*pi*(f+i)*t);
xlabel("Temps");
plot(t, s1+s2, ["b;df=" num2str(i) ";"]);

print("battement.png", "-dPNG");
