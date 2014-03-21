%
% TRAIT1.m
%
%
% exemple de traitement des signaux de mesures FRF
% par circle-fit
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
% qui comporte N

Nfrf=9; % nombre de FRF 

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

% attention, on travaille sur des mobilites (Vitesse/Force)
% alors que les données d'origine sont des accélérances Accélération/Force
% on divise donc par j2piFreq

FRFmob=FRF./(j*2*pi*Freq);
FRFmobmem=FRFmob; % on les mémorise car on va en modifier certaines + loin

% affichage des FRF (modules / linéaire)

figure(1)
semilogy(freq,abs(FRFmob))
grid on
legend('FRF1','FRF2','FRF3','FRF4','FRF5')
xlabel('Frequences (Hz)');ylabel('FRF mobilites (lin)')


% nombre de maxima (donc de modes) sélectionnés par l'opérateur

Nmax=input('Nombre de max retenus=');
Fmin=zeros(1,Nmax);
Fmax=zeros(1,Nmax);

% sélection manuelle des intervalles fréquentiels

figure(1)
disp('Selectionner avec la souris les Nmax intervalles autour des pics (2Nmax valeurs)')

[a,b]=ginput(2*Nmax);
Fmin=zeros(1,Nmax);
Fmax=zeros(1,Nmax);

for l=1:2:2*Nmax-1
    k=fix((l-1)/2+1);
    Fmin(k)=a(l);
    Fmax(k)=a(l+1);
end

% indice (axe des fréquences) correspondant

indmin=fix(Fmin/df+1);
indmax=fix(Fmax/df+1);


figure(2)
for k=1:Nfrf
    eval(['subplot(91' num2str(k) ')'])
    plot(freq,angle(FRF(:,k)))
    grid on
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% COEUR DU PROGRAMME
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% on évalue par la technique du circle-fit
% le modèle suivant de FRF
%
%	FRFmob = G0 + R1*H(f) ou H(f) est un pic de Lorentz :
%
%	              j(f/fr)/Q
%	H(f) = -----------------------
%              1-(f/fr)**2 + j(f/fr)/Q
%
% à l'aide de la fonction lms_cerc

G0=zeros(Nfrf,Nmax); % constante du modèle
fr=zeros(Nfrf,Nmax); % fréquence de résonance (Hz)
Q=zeros(Nfrf,Nmax); % facteur de qualité
R1=zeros(Nfrf,Nmax); % rayon du cercle de Nyquist
FRFmob_modele=zeros(Nfrf,Nmax); % valeur de la FRFmob à la résonance
m=0;

for l=1:Nmax % numéro du maximum analysé
    for k=1:Nfrf % numéro de la FRF analysée
        % attention : il faut que les parties réelles des FRF soient
        % positives pour l'estimation des paramètres du modèle
        % d'où le test
        if mean(real(FRFmob(indmin(l):indmax(l),k)))<0
            FRFmob(indmin(l):indmax(l),k)=-FRFmob(indmin(l):indmax(l),k);
        end
        % appel à la routine lms_cerc
        [G0tmp,frtmp,Qtmp,R1tmp]=lms_cerc(freq(indmin(l):indmax(l)),FRFmob(indmin(l):indmax(l),k));
        G0(k,l)=G0tmp;
        fr(k,l)=frtmp;
        Q(k,l)=Qtmp;
        R1(k,l)=R1tmp;
        FRFmob_modele(k,l)=(G0tmp+R1tmp);
    end
end

xi=1./(2*Q); % facteur d'amortissement

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% les paramètres importants en sortie
%
% les fréquences de rés fr
% les amortissements xi
% les valeurs de la FRF en fr FRFmob_modele
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

frmean=mean(fr)
ximean=mean(xi)

