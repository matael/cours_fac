clear all;
close all;

% axe des temps
t = linspace(0, 10, 500);

% Schema subplot :
%
% +------------------+
% |     Battement    |
% +------------------+
% 
% +------------------+
% |    Fréquences    |
% |     Multiples    |
% +------------------+

% Battement
a = 5; % amplitude
f = 100; % frequence
df = 1; % Df
s1 = a*sin(2*pi*f*t);
s2 = a*sin(2*pi*(f+df)*t);
stot = s1+s2;

subplot(2,1,1);
title(["Battement ( difference de frequence : " num2str(df) " )"]);
hold on;
plot(t, s1, "b");
plot(t, s2, "k");
plot(t, stot, "r");
ylabel("Pression");
grid on;
legend("s1", "s2", "s1+s2");
hold off;


% Frequences multiples

fact = 2; % f*fact
s1 = a*sin(2*pi*f*t);
s2 = a*sin(2*pi*f*fact*t);
stot = s1+s2;

subplot(2,1,2);
title(["Frequences multiples (facteur : " num2str(fact) " )"]);
hold on;
plot(t, s1, "b");
plot(t, s2, "k");
plot(t, stot, "r");
xlabel("Temps");
ylabel("Pression");
grid on;
legend("s1", "s2", "s1+s2");
hold off;

print("battement_multiples.png", '-dPNG');
