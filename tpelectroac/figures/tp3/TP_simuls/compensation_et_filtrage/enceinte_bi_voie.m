clc;clear all;close all;


rho=1.2;    %masse volumique de l'air
c0=344;     %célérité du son

r=1;        %distance source-microphone

%%%%%%%%%%%%%%%%%%
% ampli audio %%%%
%%%%%%%%%%%%%%%%%%
Ug=5;       % tension 
Rg=0;       % résistance de sortie de l'ampli

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% bande de fréquence d'analyse %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq=[10:2:10000];
omega=2.*pi.*freq;
k0=omega./c0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% choix de la configuration étudiée %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%filtre=0;   %pas de filtrage
%filtre=1;   %filtre ordre 1
filtre=2;   %filtre ordre 2

if filtre~=0;
    f_rac=input('donner la fréquence de raccordement (Hz)');
else
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% medium %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% caractéristiques électromécaniques %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r_med=0.085;        % rayon membrane
S_med=pi.*r_med.^2;     % surface membrane
Re_med=6.2;         % résitance bobine
Le_med=0.57e-3;     % inductance bobine
Qms_med=3.12;
Qes_med=0.90;
Vas_med=16.34e-3;
fs_med=62.3;        % fréquence de résonance équipage mobile

Cm_med=Vas_med./(rho.*c0.^2.*S_med.^2);
Mm_med=1./(4.*pi.^2.*Cm_med.*fs_med.^2);
Rm_med=1./(2.*pi.*fs_med.*Cm_med.*Qms_med);
Zm_med=Rm_med+j.*Mm_med.*omega+1./(j.*Cm_med.*omega);
Bl_med=sqrt(2.*pi.*fs_med.*Re_med.*Mm_med./Qes_med);
Qts_med=Qms_med.*Qes_med./(Qms_med+Qes_med);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% impedance de charges acoustique %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%
%% avant %%%%
%%%%%%%%%%%%%


Z_ray_med=rho.*c0./S_med.*(1-besselj(1,2.*k0.*r_med)./(k0.*r_med)+j.*struve(1,2.*k0.*r_med)./(k0.*r_med));
Z_av_med=Z_ray_med;

%%%%%%%%%%%%%
% arrière %%%
%%%%%%%%%%%%%
V_enceinte=20e-3;
C_enceinte=V_enceinte./(rho.*c0.^2);
Z_ar_med=1./(j.*C_enceinte.*omega);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% paramètres électroméca vus côté acoustique %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rea_med=(Bl_med./S_med).^2./(Rg+Re_med);
Cea_med=Le_med.*(S_med./Bl_med).^2;
Rma_med=Rm_med./S_med.^2;
Mma_med=Mm_med./S_med.^2;
Cma_med=Cm_med.*S_med.^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% paramètres électroméca vus côté électrique %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mme_med=Mm_med./Bl_med.^2;
Cme_med=Cm_med.*Bl_med.^2;
Rme_med=Bl_med.^2./Rm_med;
Zeav_med=Bl_med.^2./(S_med.^2.*Z_av_med);
Zear_med=Bl_med.^2./(S_med.^2.*Z_ar_med);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% impédance électrique  %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Z_HP_med=Re_med; %HP supposé compensé

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% tweeter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% caractéristiques électromécaniques %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r_twe=0.0125;        % rayon membrane
S_twe=pi.*r_twe.^2;     % surface membrane
Re_twe=6.2;         % résitance bobine
Le_twe=0.06e-3;     % inductance bobine
Qms_twe=3.37;
Qes_twe=1;
Cm_twe=8e-5;
Mm_twe=0.4e-3;

fs_twe=1./2./pi./sqrt(Mm_twe.*Cm_twe);        % fréquence de résonance équipage mobile
Vas_twe=Cm_twe.*rho.*c0.^2.*S_twe.^2;


Rm_twe=1./(2.*pi.*fs_twe.*Cm_twe.*Qms_twe);
Zm_twe=Rm_twe+j.*Mm_twe.*omega+1./(j.*Cm_twe.*omega);
Bl_twe=sqrt(2.*pi.*fs_twe.*Re_twe.*Mm_twe./Qes_twe);
Qts_twe=Qms_twe.*Qes_twe./(Qms_twe+Qes_twe);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% impedance de charges acoustique %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%
%% avant %%%%
%%%%%%%%%%%%%


Z_ray_twe=rho.*c0./S_twe.*(1-besselj(1,2.*k0.*r_twe)./(k0.*r_twe)+j.*struve(1,2.*k0.*r_twe)./(k0.*r_twe));
Z_av_twe=Z_ray_twe;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% paramètres électroméca vus côté acoustique %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rea_twe=(Bl_twe./S_twe).^2./(Rg+Re_twe);
Cea_twe=Le_twe.*(S_twe./Bl_twe).^2;
Rma_twe=Rm_twe./S_twe.^2;
Mma_twe=Mm_twe./S_twe.^2;
Cma_twe=Cm_twe.*S_twe.^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% paramètres électroméca vus côté électrique %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mme_twe=Mm_twe./Bl_twe.^2;
Cme_twe=Cm_twe.*Bl_twe.^2;
Rme_twe=Bl_twe.^2./Rm_twe;
Zeav_twe=Bl_twe.^2./(S_twe.^2.*Z_av_twe);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% impédance électrique  %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Z_HP_twe=Re_twe; %HP supposé compensé

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% dimensionnement des filtres %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%
% sans filtre %
%%%%%%%%%%%%%%%
if filtre==0
    Ugf_med=Ug.*ones(size(freq));
    Ugf_twe=Ug.*ones(size(freq));
else
end


%%%%%%%%%%%%
%% ordre 1%%
%%%%%%%%%%%%

if filtre==1
    L=1./(2.*pi).*Re_med./f_rac;
    Ugf_med=Ug.*Z_HP_med./(Z_HP_med+j.*L.*omega);
    C=1./(2.*pi)./Re_twe./f_rac;
    Ugf_twe=Ug.*Z_HP_twe./(Z_HP_twe+1./(j.*C.*omega));
else
end
%%%%%%%%%%%%
%% ordre 2 %
%%%%%%%%%%%%

if filtre==2
    Lmed=sqrt(2)./(2.*pi.*f_rac).*Re_med;
    Cmed=1./(2.*pi.*sqrt(2).*f_rac.*Re_med);
    Zeqm=(Z_HP_med./(j.*Cmed.*omega))./(Z_HP_med+1./(j.*Cmed.*omega));
    Ugf_med=Ug.*Zeqm./(Zeqm+j.*Lmed.*omega);
    Ltwe=sqrt(2)./(2.*pi.*f_rac).*Re_twe;
    Ctwe=1./(2.*pi.*sqrt(2).*f_rac.*Re_twe);
    Zeqt=(Z_HP_twe.*j.*Ltwe.*omega)./(Z_HP_twe+j.*Ltwe.*omega);
    Ugf_twe=Ug.*Zeqt./(Zeqt+1./(j.*Ctwe.*omega));
else
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% réponse en fréquence %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w_med_pg=1./(Rea_med+Rma_med+j.*Mma_med.*omega+1./(j.*Cma_med.*omega)+Z_av_med+Z_ar_med); 
p_med_pg=sqrt(rho.*c0./(4.*pi.*r.^2).*real(Z_av_med)).*w_med_pg;                        
pg_Ugf_med=Bl_med./(Rg+Re_med+j.*omega.*Le_med)./S_med;
w_med_Ugf=w_med_pg.*pg_Ugf_med;
p_med_Ugf=p_med_pg.*pg_Ugf_med;
p_med_Ug=p_med_Ugf.*Ugf_med./Ug;
Lp_med=20.*log10(abs(p_med_Ug)./sqrt(2).*abs(Ug)./2e-5);


w_twe_pg=1./(Rea_twe+Rma_twe+j.*Mma_twe.*omega+1./(j.*Cma_twe.*omega)+Z_av_twe);
p_twe_pg=sqrt(rho.*c0./(4.*pi.*r.^2).*real(Z_av_twe)).*w_twe_pg;                        
pg_Ugf_twe=Bl_twe./(Rg+Re_twe+j.*omega.*Le_twe)./S_twe;
w_twe_Ugf=w_twe_pg.*pg_Ugf_twe;
p_twe_Ugf=p_twe_pg.*pg_Ugf_twe;
p_twe_Ug=p_twe_Ugf.*Ugf_twe./Ug;
Lp_twe=20.*log10(abs(p_twe_Ug)./sqrt(2).*abs(Ug)./2e-5);               % niveau de pression rayonné en dB SPL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% visualisation des filtres %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Gdb_med=20.*log10(abs(Ugf_med./Ug));
angle_med=angle(Ugf_med./Ug);

Gdb_twe=20.*log10(abs(Ugf_twe./Ug));
angle_twe=angle(Ugf_twe./Ug);

figure(1);
subplot(211);semilogx(freq,Gdb_med,'r',freq,Gdb_twe,'b');
subplot(212);semilogx(freq,180./pi.*angle_med,'r',freq,180./pi.*angle_twe,'b');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% visualisation du niveau de pression rayonné %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


texte_titre=['niveau de pression rayonné (dB SPL) pour une tension de sortie Ug=',num2str(Ug./sqrt(2)),' Vrms']; 

p_med=p_med_Ugf.*Ugf_med;
p_twe=p_twe_Ugf.*Ugf_twe;
p_tot=p_med+p_twe;
Lp_tot=20.*log10(abs(p_tot)./sqrt(2)./2e-5);

figure(2);
subplot(211);semilogx(freq,Lp_med,'r',freq,Lp_twe,'b',freq,Lp_tot,'k');xlabel('frequence (Hz)');ylabel('L_p (dB SPL)');
legend('medium','tweeter','Med+Twe');title(texte_titre);
subplot(212);semilogx(freq,180./pi.*unwrap(angle(p_med)),'r',freq,180./pi.*unwrap(angle(p_twe)),'b');xlabel('frequence (Hz)');ylabel('\Phi (°)');
legend('medium','tweeter');


