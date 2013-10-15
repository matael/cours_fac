clear all;
close all;

% on calcule la suite d'approximation de exp(1) et on
% arrête de calculer dès que l'erreur commise passe sous
% 0.5e-5 (5 décimales correctes)

err = 1;
exp_e = 0;
n = 0;

while (err > 0.5e-5)
	exp_e = exp_e + (1^n)/factorial(n);
	n = n+1;
	err = abs(exp(1)-exp_e);
end

disp(num2str(exp_e));

