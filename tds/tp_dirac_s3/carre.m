function [t,s,N,fe]=carre(A0,F0,N0,Nperiodes);

%
% parametres d'entree : 
%		A0 : amplitude du carré
%		F0 : frequence du signal carré
%		N0 : nombre de points par période
%		Nperiodes : nombre de périodes
%
% parametres de sortie :
%		t : axe temporel
%		s : signal carre a temps discret possédant un 
%       nombre entier de périodes
%       N : nombre de points du signal
%       fe : fréquence d'échantillonnage du signal
%
if mod(N0,2) 
    disp('ATTENTION, le nombre de points par période doit être un nombre pair ! ')
    N=0;
    fe=0;
    t=0;
    s=0;
    return
else
    fe=N0*F0;
    N=ceil(N0*Nperiodes);
    t=(0:N-1)/fe;

    s=A0*sign(sin(2*pi*F0*t+0.01));
    
endif


