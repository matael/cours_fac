function [data]=CTTM_read_txt(filename,cols)

% CTTM_read_txt
%
% Fonction matlab & GNU/Octave pour lire les fichiers .txt
% générés par le programme Analyseur CTTM.
%
% Entrée :
% 	- nom du fichier à lire
% 	- nombre de colonnes
%
% Sortie
% 	- données lues
%

if cols<1
	disp('cols must greater than 1 or equal');
end

fid = fopen(filename);
% on vire la ligne d'en-tête
fgetl(fid);

% création de la chaine de formattage
format = '%e';
i = 0;
while i<cols
	format = [format '\t%e'];
	i = i+1;
end

data = fscanf(fid, format, [cols inf]);

data = data';

end
