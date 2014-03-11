clc;clear all;close all;


rho=1.2;        %masse volumique de l'air
c0=344;         %célérité du son
mu=1.84E-5;     %viscosité dynamique
k_gaz=2.6334e-2;%conductivité thermique
Cp_gaz=1003;    %capacité calorifique
gamma=1.4;      %coefficient polytropique du gaz

%%%%%%%%%%%%%%%%%%
% ampli audio %%%%
%%%%%%%%%%%%%%%%%%
Ug=5;       % tension 
Rg=0;       % résistance de sortie de l'ampli

%%%%%%%%%%%%%%%%%%
% enceinte %%%%%%%
%%%%%%%%%%%%%%%%%%

V_ar=20e-3;
C_ar=V_ar./(rho.*c0.^2);


%%%%%%%%%%%%%%%%%%
%% tube %%%%%%%%%%
%%%%%%%%%%%%%%%%%%
r_tube=3e-2;
L_tube=1;
S_tube=pi.*r_tube.^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% bande de fréquence d'analyse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq=[10:2:1000];
omega=2.*pi.*freq;
k0=omega./c0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% caractéristique constructeur AUDAX HP170 MO %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=r_tube;        % rayon membrane
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

%charge arrière

Z_ar=1./(j.*C_ar.*omega);     %impédance de charge arrière

%charge avant (voir formule impédance ramenée dans le cours)



pertes=10;   %avec pertes dans le tube
%pertes=0;  %sans pertes dans le tube

if pertes==0;
    Zc=rho.*c0./S_tube;
    Z_ramenee=Zc./(j.*tan(k0.*L_tube));
else
    lv=mu./(rho.*c0);
    lh=k_gaz./(rho.*c0.*Cp_gaz);
    kv=sqrt(-j.*omega./(c0.*lv));
    kh=sqrt(-j.*omega./(c0.*lh));
    Kv=2./(kv.*r_tube).*besselj(1,kv.*r_tube)./besselj(0,kv.*r_tube);
    Kh=2./(kh.*r_tube).*besselj(1,kh.*r_tube)./besselj(0,kh.*r_tube);
    Zc=rho.*c0./S./sqrt(1-Kv)./sqrt(1+(gamma-1).*Kh);
    GAMMA=j.*k0.*sqrt(1+(gamma-1).*Kh)./sqrt(1-Kv);
    Z_ramenee=Zc./tanh(GAMMA.*L_tube);
end

Z_av=Z_ramenee;

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

figure(1);
subplot(211);plot(freq,abs(Z_HP));xlabel('frequence (Hz)');ylabel('|Z_{HP}|');
subplot(212);plot(freq,angle(Z_HP));xlabel('frequence (Hz)');ylabel('Arg(Z_{HP})');




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% réponse en fréquence (voir transparents de cours) %%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if pertes==0;
    Zc=rho.*c0./S_tube;
    Za=j.*Zc./tan(k0.*L_tube./2);
    Zb=Za;
    Zpi=-j.*Zc.*sin(k0.*L_tube);
else
    lv=mu./(rho.*c0);
    lh=k_gaz./(rho.*c0.*Cp_gaz);
    kv=sqrt(-j.*omega./(c0.*lv));
    kh=sqrt(-j.*omega./(c0.*lh));
    Kv=2./(kv.*r_tube).*besselj(1,kv.*r_tube)./besselj(0,kv.*r_tube);
    Kh=2./(kh.*r_tube).*besselj(1,kh.*r_tube)./besselj(0,kh.*r_tube);
    Zc=rho.*c0./S./sqrt(1-Kv)./sqrt(1+(gamma-1).*Kh);
    GAMMA=j.*k0.*sqrt(1+(gamma-1).*Kh)./sqrt(1-Kv);
    Za=Zc./tanh(GAMMA.*L_tube./2);
    Zb=Za;
    Zpi=Zc.*sinh(GAMMA.*L_tube);
end

w_pg=1./((Rea./(j.*omega.*Cea))./(Rea+1./(j.*omega.*Cea))+Rma+j.*Mma.*omega+1./(j.*Cma.*omega)+Z_av+Z_ar);  
p_entree_tube_pg=Z_ramenee.*w_pg;
p_terminal_pg=Zb./(Zpi+Zb).*p_entree_tube_pg;
pg_Ug=Bl./(Rg+Re+j.*omega.*Le)./S;
p_terminal_Ug=p_terminal_pg.*pg_Ug;


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% réponse en fréquence %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%



figure(2);
subplot(211);
plot(freq,20.*log10(abs(p_terminal_Ug)));xlabel('frequence (Hz)');ylabel('|p/U_g| (dB)');
subplot(212);
plot(freq,angle(p_terminal_Ug));xlabel('frequence (Hz)');ylabel('Arg(p/U_g)');

% figure(1)
% print('-dpng','Zhp_guide_onde_sans_pertes.png');
% figure(2)
% print('-dpng','p_ug_guide_onde_sans_pertes.png');
