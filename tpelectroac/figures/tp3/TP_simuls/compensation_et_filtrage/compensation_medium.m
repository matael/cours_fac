clc;clear all;close all;


rho=1.2;    %masse volumique de l'air
c0=344;     %célérité du son

r=1;        %distance source-microphone

%%%%%%%%%%%%%%%%%%
% ampli audio %%%%
%%%%%%%%%%%%%%%%%%
Ug=5;       % tension 
Rg=0;       % résistance de sortie de l'ampli

%%%%%%%%%%%%%%%%%%
% enceinte %%%%%%%
%%%%%%%%%%%%%%%%%%

V_enceinte=20e-3;
C_enceinte=V_enceinte./(rho.*c0.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% bande de fréquence d'analyse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq=[10:2:10000];
omega=2.*pi.*freq;
k0=omega./c0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% caractéristique constructeur AUDAX HP170 MO %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=0.085;        % rayon membrane
S=pi.*a.^2;     % surface membrane
Re=6.2;         % résitance bobine
Le=0.57e-3;     % inductance bobine
Qms=3.12;
Qes=0.90;
Vas=16.34e-3;

fs=62.3;        % fréquence de résonance équipage mobile


Cm=Vas./(rho.*c0.^2.*S.^2);
Mm=1./(4.*pi.^2.*Cm.*fs.^2);
Rm=1./(2.*pi.*fs.*Cm.*Qms);
Zm=Rm+j.*Mm.*omega+1./(j.*Cm.*omega);
Bl=sqrt(2.*pi.*fs.*Re.*Mm./Qes);
Qts=Qms.*Qes./(Qms+Qes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Charges acoustiques avant et arrière %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Z_ray=rho.*c0./S.*(1-besselj(1,2.*k0.*a)./(k0.*a)+j.*struve(1,2.*k0.*a)./(k0.*a));
Z_ray_approx_BF=rho.*c0./S.*(0.5.*(k0.*a).^2+j.*omega.*a./c0.*8./(3.*pi));


Z_av=Z_ray;     %impédance de charge avant
Z_ar=1./(j.*C_enceinte.*omega);     %impédance de charge arrière



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% paramètres électroméca vus côté acoustique %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rea=(Bl./S).^2./(Rg+Re);
Cea=Le.*(S./Bl).^2;
Rma=Rm./S.^2;
Mma=Mm./S.^2;
Cma=Cm.*S.^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% paramètres électroméca vus côté électrique %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mme=Mm./Bl.^2;
Cme=Cm.*Bl.^2;
Rme=Bl.^2./Rm;
Zeav=Bl.^2./(S.^2.*Z_av);
Zear=Bl.^2./(S.^2.*Z_ar);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% impédance électrique (voir poly haut-parleurs p.5) %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Zeq=1./(j.*Mme.*omega+1./Rme+1./(j.*omega.*Cme)+1./Zeav+1./Zear);
Z_HP=Re+j.*omega.*Le+Zeq;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% compensation de l'inductance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ce=Le./Re.^2;
Z_HP_comp_inductance=Z_HP.*(Re+1./(j.*omega.*Ce))./(Z_HP+Re+1./(j.*omega.*Ce));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% compensation de la résonance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Zmax,indice]=max(abs(Z_HP_comp_inductance));
fres=freq(indice);
Rs=Zmax-Re;
Ls=Rs./(2.*pi.*Qms.*fres);
Cs=Qms./(2.*pi.*Rs.*fres);
Rc=Re+Re.^2./Rs;
Lc=Re.^2.*Cs;
Cc=Ls./Re.^2;

Zc_eq=Rc+j.*Lc.*omega+1./(j.*Cc.*omega);
Z_HP_comp_resonance=Z_HP_comp_inductance.*Zc_eq./(Z_HP_comp_inductance+Zc_eq);


figure(1);
subplot(211);plot(freq,abs(Z_HP),'r',freq,abs(Z_HP_comp_inductance),'b',freq,abs(Z_HP_comp_resonance),'k');
xlabel('frequence (Hz)');ylabel('|Z_{HP}|');legend('avant compensation','compensation Le','compensation résonance')
subplot(212);plot(freq,angle(Z_HP),'r',freq,angle(Z_HP_comp_inductance),'b',freq,angle(Z_HP_comp_resonance),'k');
xlabel('frequence (Hz)');ylabel('Arg(Z_{HP})');legend('avant compensation','compensation Le','compensation résonance')



figure(2);
subplot(211);plot(freq,real(Z_HP),'r',freq,real(Z_HP_comp_inductance),'b',freq,real(Z_HP_comp_resonance),'k');
xlabel('frequence (Hz)');ylabel('\Re(Z_{HP})');legend('avant compensation','compensation Le','compensation résonance')
subplot(212);plot(freq,imag(Z_HP),'r',freq,imag(Z_HP_comp_inductance),'b',freq,imag(Z_HP_comp_resonance),'k');
xlabel('frequence (Hz)');ylabel('\Im(Z_{HP})');legend('avant compensation','compensation Le','compensation résonance')