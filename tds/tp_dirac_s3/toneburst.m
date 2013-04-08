function [t,s]=toneburst(Ncycle,Nburst,Fburst,Fe,F0);
%
% function [t,s]=toneburst(Ncycle,Nburst,Fburst,fe,f0);
%
% paramètres d'entrée : 
%		Ncycle : nombre de périodes de sinus par burst
%		Nburst : nombre de bursts
%		Fburst : fréquence de répétition des bursts
%		Fe : fréquence d'échantillonnage en Hz
%		F0 : fréquence du sinus en Hz
%
% paramètres de sortie : 
%       t : axe temporel
%		s : séquence temporelle
%
% si possible choisir Fe/F0 entier...

% qqs vérifs de base
% Ncycle/F0<=1/Fburst
if Fburst>F0/Ncycle
   return
end

N1cycletot=fix(Fe/Fburst); % nombre de points d'une période entière (complétée des zéros)
Ntot=N1cycletot*Nburst;
t=(0:Ntot-1)/Fe;
s=zeros(1,Ntot);
Nsin=fix(Fe/F0); % nombre de points d'un cycle (sans les zéros)
sref=sin(2*pi*F0*t(1:Ncycle*Nsin));
for k=1:Nburst
   s((k-1)*N1cycletot+1:(k-1)*N1cycletot+Ncycle*Nsin)=sref;
end



