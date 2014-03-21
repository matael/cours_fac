%
% Estimation des parametres d'un cercle de Kennelly (pic de Lorentz)
% par une methode des moindres carres (These JC Le Roux, 1994) a partir
% d'un vecteur simp() de valeurs complexes aux frequences sfre() :
%
%	function [G0,fr,Q,R1]=lms_cerc(sfre,simp)  (>= 3 points !!!)
%
%	G = G0 + R1*H(f) ou H(f) est un pic de Lorentz :
%
%	              j(f/fr)/Q
%	H(f) = -----------------------
%              1-(f/fr)**2 + j(f/fr)/Q
%
% version 1.0 - 22/6/98 - P. Herzog
% test npts - 10/12/2004 - P. Herzog
%
function [G0,fr,Q,R1]=lms_cerc(sfre,simp)

% parametres de calcul :
npts=length(simp);
if npts<3
   error('Moins de 3 points fournis')
end
szx=real(simp);
szy=imag(simp);

% sommes des termes :
PR1=sum(szx);
PR2=sum(szx.*szx);
PR3=sum(szx.*szx.*szx);
PX1=sum(szy);
PX2=sum(szy.*szy);
PX3=sum(szy.*szy.*szy);
PK11=sum(szx.*szy);
PK12=sum(szx.*szy.*szy);
PK21=sum(szx.*szx.*szy);

% calcul des variables statistiques :
Pr=(PR1*PR1/npts)-PR2;
Px=(PX1*PX1/npts)-PX2;
P21=PK21+PX3-(PR2*PX1/npts)-(PX2*PX1/npts);
P12=PK12+PR3-(PR1*PX2/npts)-(PR1*PR2/npts);
P11=(PR1*PX1/npts)-PK11;
D=2.0*(Pr*Px-P11*P11);

% coordonnees du cercle de Kennelly :
Rce=(P21*P11-P12*Px)/D;
Xce=(P12*P11-P21*Pr)/D;
rayon=(Rce*Rce)+(Xce*Xce)-(2*Rce*PR1/npts);
rayon=sqrt(rayon-(2*Xce*PX1/npts)+(PR2/npts)+(PX2/npts));

% valeurs des variables de sortie :
G0=Rce-rayon+j*Xce;
R1=2*rayon;

% reduction de l'intervalle :
fr=[];
im=[];
for i=1:length(simp)
    % pour prendre en compte des situations très résonantes
  if (real(simp(i))>Rce/4)&(sfre(i)>0)
  %if (real(simp(i))>Rce)&(sfre(i)>0)
    fr=[fr sfre(i)];
    im=[im simp(i)];
  end
end
zx=real(im);
zy=imag(im);
n=length(im);

if n >= 2
  % graduation frequentielle :
  ta2=(zy-Xce)./(zx+(rayon-Rce));
  F1=sum(fr.*fr);
  usfr=1./fr;
  F2=sum(usfr.*usfr);
  T1=sum(ta2.*fr);
  T2=sum(ta2.*usfr);

  % calcul des parametres frequentiels :
  fr=sqrt((n*T1-T2*F1)/(T1*F2-n*T2));
  Q=sqrt((n*T1-T2*F1)*(T1*F2-n*T2))/(F1*F2-n*n);
else
  fr=0.;
  Q=0.;
end
