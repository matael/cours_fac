%
% TRAIT0.m
%
%
% exemple de traitement des signaux de mesures FRF
% pour TP analyse modale
%
% Détermination des paramètres modaux d'une poutre
%
% Laurent SIMON
% Mars 2012
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ATTENTION - ATTENTION - ATTENTION
% après la ligne eval de l'exemple donné dans le texte
% ajouter
%
% save FRF1 FRF1 freq
%
% puis remplacer k=1 par k=2
% etc...
%
% une fois les 5 acquisitions effectuées, 
% on dispose de 5 fichiers FRF1.mat à FRF5.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MISE EN FORME DES DONNEES
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% chargement des 5 FRF
% on les stocke dans un fichier unique

Nfrf=5; % nombre de FRF 

for k=1:Nfrf
    eval(['load FRF' num2str(k)])
    eval(['FRF(:,k)=FRF' num2str(k) ';'])
    eval(['clear FRF' num2str(k)])
end

clear SLm

% axe des fréquences

freq=freq.';
df=freq(2)-freq(1); % intervalle Delta F entre 2 fréquences 
Freq=freq*ones(1,Nfrf);

% attention, soit on travaille sur des mobilites (Vitesse/Force)
% soit on conserve les données d'origine qui sont des accélérances Accélération/Force
% pour obtenir des mobilites, on divise donc par j2piFreq

FRFmob=FRF./(j*2*pi*Freq);

% affichage des FRF (modules / linéaire)

figure(1)
hold off
for k=1:Nfrf
    eval(['subplot(51' num2str(k) ')'])
    semilogy(freq,abs(FRF(:,k)))
    %semilogy(freq,abs(FRFmob))
    grid on
    xlabel('Frequences (Hz)');ylabel('Module FRF')
end
zoom on

figure(2)
for k=1:Nfrf
    eval(['subplot(51' num2str(k) ')'])
    plot(freq,angle(FRF(:,k)))
    grid on
    xlabel('Frequences (Hz)');ylabel('Phase FRF')
end
zoom on
