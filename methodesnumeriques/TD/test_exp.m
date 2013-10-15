clear all;
close all;

%
% On cherche à approximer la valeur de exp(1) par le calcul
% des 5 et 15 premiers termes de la suite qui la définit.
%
% on affiche ensuite l'erreur commise par rapport à la fonction exp(1)

exp_e15 = 0;
exp_e5 = 0;

for i=(0:5)
	exp_e5 = exp_e5 + (1^i)/factorial(i);
end
for i=(0:15)
	exp_e15 = exp_e15 + (1^i)/factorial(i);
end

disp(['Erreur |e-exp_e15| : ', num2str(abs(exp(1)-exp_e15))]);
disp(['Erreur |e-exp_e5| : ', num2str(abs(exp(1)-exp_e5))]);


