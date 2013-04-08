clear all;
close all;

% nom du fichier à analyser (.wav)
filename = 'countdown1.wav';
% nom du dossier où enregistrer les graphes
dossier = 'countdown_test1';
% taille totale de la fenêtre à analyser (en points)
pas = 10000;
% nombre de point de la TFD
Ntfd=pas;
Fe = 44100; % fréquence d'échant.


% On commence par vérifier que le dossier pour enregistrer les images existe
if length(glob(dossier))==0
	% s'il n'existe pas, on quitte
	disp(["Le dossier n'existe pas : " dossier ]);
	exit(0);
endif

% On lit le contenu du fichier
file = wavread(filename);
len = length(file);

% connaitre la longueur du plus grand des numéros de fichiers (pour les graphes)
% pour faire la vidéo finale, ffmpeg a besoin de noms particuliers
next = 1;
max_num = 1;
while next+pas <= len
	max_num += 1;
	next += pas/2;
endwhile
max_num = length(num2str(max_num));


%% on crée l'axe des fréquences
freqs = (0:(Ntfd-1))*(Fe/Ntfd);


% Analyse proprement dite
next = 1; % next représente le premier point de la fenêtre a analyser
i = 0; % simple compteur pour les noms de fichiers
while next+pas <= len
	% on commence par enlever le graphe précédent
	close all;

	% On dit à l'utilisateur sur quoi on bosse (debug)
	disp(['Analyse de la fenêtre ' num2str(i) ': ' num2str(next) ' -> ' num2str(next+pas)]);


	% Calcul de la TFD

	%% on commence par extraire la séquence :
	seq = file(next:next+pas);

	%% on calcule le module de son spectre
	spectre = fft(seq, Ntfd);
	module_spectre = 20*log10(abs(spectre));

	plot(freqs, module_spectre);
	xlim([0 2500]); % pas besoin de plus (voix humaine)
	ylim([-80 80]); % pour avoir toujours le même axe y

	title(['Analyse ' filename ' [' num2str(next) '->' num2str(next+pas) ']']);


	%% ajouter des zéros avant le i pour le tri (nom de fichier)
	padding_needed = max_num-length(num2str(i))
	if padding_needed > 0
		count = 0;
		padding = [];
		while count<padding_needed
			padding = ['0' padding];
			count += 1;
		endwhile
	else
		padding = [];
	endif


	%% créer l'image
	print([dossier '/' padding num2str(i) '.png'], '-dpng');

	% Pas suivant
	i += 1;
	next += pas/2;
endwhile
