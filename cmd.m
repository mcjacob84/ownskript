
%%
%Neues Projekt
%->1. Schritt
%Matrix mit firetimes �ber die Stimulationen hinweg
%init
cfg.dataSet={'firetimes','mfpot'};
cfg.isNoise=1;

for l=1:length(cfg.dataSet)
    for stim=0:0.01:0.4
        load(strcat('SO_',cfg.dataSet{l},'_Stim',num2str(stim),'_Noise',num2str(cfg.isNoise),'.mat'));
        
        for fibretype = 1:121
            firetimes{round((stim*100)+1)}(fibretype,:)=f_peakFinder_FT(stim,fibretype);
        end
    end
end




%%
%%%%%%%%%%%%%
% % % % % % %
% TRASHCAN  %
% % % % % % %
%%%%%%%%%%%%%
%%
%Project: MouseVsManVsGiant

load('MouseVsMenVsGiant1_Noise1_c106_stim1_ParamNum0.mat','forces');
force1=forces;
load('MouseVsMenVsGiant2_Noise1_c106_stim1_ParamNum0.mat','forces');
forces2=forces;
load('MouseVsMenVsGiant3_Noise1_c106_stim1_ParamNum0.mat','forces');
forces3=forces;
load('MouseVsMenVsGiant4_Noise1_c106_stim1_ParamNum0.mat','forces');
forces4=forces;

%�ndere Ordner
force1=f_myPool(forces1);
force2=f_myPool(forces2);
force3=f_myPool(forces3);
force4=f_myPool(forces4);



%%
%Skript um States zu extrahieren und zu plotten
%Erzeugt Grafiken der States
    %first load states
    %second mk folder to print files
    %then skript
a=figure;
for m = 1:62
for n = 1 : 121
    cfg(n,:)=tmp_x{n}(m,:);
end
plot(cfg')
print(a,'-dpng',strcat('SOF0N1_States(',num2str(m),').png'))
end

%%
%Grafik Allgemeines Verhalten phModell
figure
for s = 0:0.1:1
[~,T,qH1]=myHatze(7,s,0,11.3,4.4542,3);%m,rho_c,nu
%[~,T,qH1]=myHatze(7,s,0,5.2857,1.9068,4.613);%m,rho_c,nu
T=T(1:2001);
T=T.*1000;
qH1=qH1(1:2001);
plot(T,qH1,'b')
hold on
if s==0.1
    text(T(501),qH1(501)+0.07,'\sigma = 0,1','Fontsize',19)
end
if s==1
    text(T(501),qH1(501)+0.06,'\sigma = 1','Fontsize',19)
end
xlabel('Zeit [ms]','Fontsize',19)
ylabel('normierte Kraft F','Fontsize',19)
set(gca,'Fontsize',19)
ylim([0 1.1])
end

%%
%Grafiken vgl bp-Modell mit ph-Modell bei translation of sigma
data=106;
isNoise=1;

x=[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
y=[-0.0384,0.0493,0.1264,0.1898,0.2595,0.3328,0.4130,0.5243,0.6748,0.8718,1.0265];

figure

for n=0:10
load(strcat('MA_SN_pPS_Noise',num2str(isNoise),'_c',num2str(data),'_',num2str(n),'.mat'));
force=f_myPool(forces);
force=f_normShorten_SNF0(force,isNoise);

[~,T,~,~] = myHatze(106,1,0,11,4.4525,3);

hold on
plot(T,force)
ylim([0 1.1])
ylabel('norm. F','Fontsize',19)
xlabel('Zeit [ms]','Fontsize',19)
set(gca,'Fontsize',19)
end

for n = 0:10
    [~,T,q,~] = myHatze(106,y(n+1),0,11,4.4525,3);
    plot(T,q)
end
%%
%Grafik: Einfluss der Parameter
figure
for s=10:-1:0
    if s==10 || s==1
%         [~,T,qH1]=myHatze(7,s/10,0,11.25,4.4525,3)
%         [~,~,qH2]=myHatze(7,s/10,0,7.5,4.4525,3)
%         [~,~,qH3]=myHatze(7,s/10,0,3.67,4.4525,3)
        
%         [~,T,qH1]=myHatze(7,s/10,0,11,11,3)
%         [~,~,qH2]=myHatze(7,s/10,0,11,7.24,3)
%         [~,~,qH3]=myHatze(7,s/10,0,11,4.4525,3)
        
        [~,T,qH1]=myHatze(7,s/10,0,11,4.4525,4)
        [~,~,qH2]=myHatze(7,s/10,0,7.5,4.4525,3)
        [~,~,qH3]=myHatze(7,s/10,0,4,4.4525,2)

        T=T(1:2001);
        T=T.*1000;
        qH1=qH1(1:2001);
        qH2=qH2(1:2001);
        qH3=qH3(1:2001);
        hold on
        if s==10
            plot(T,qH1,T,qH2,T,qH3,'LineWidth',1.7)
%             legend('m=11,25','m=7,5','m=3,67')
%             legend('\rho_c=11','\rho_c=7,24','\rho_c=4,4525')
            legend('\nu=4','\nu=3','\nu=2')
        else
            plot(T,qH1,'--',T,qH2,'--',T,qH3,'--','LineWidth',1.7)
        end
        xlabel('Zeit [ms]','Fontsize',19)
        ylabel('normierte Kraft F','Fontsize',19)
        set(gca,'Fontsize',19)
    end
end

%%
%Grafik Ausschaltverhalten P1
figure
load(strcat('Eingang/pPS_Noise1_c7_10.mat'),'forces');
    forceS=f_myPool(forces);
    forceS=f_normShorten(forceS,1);
[~,T,qH]=myHatze(7,1,0,1.8079,4.4525,3);

% forceS=forceS(1:2001);
% T=T(1:2001);
% T=T.*1000;
% qH=qH(1:2001);

plot(T,qH,T,forceS,'LineWidth',1.7)
ylim([0,1.1])
%ylim funktioniert nicht?
xlabel('Zeit [ms]','Fontsize',19);
ylabel('normierte Kraft F','Fontsize',19);
set(gca,'Fontsize',19)

%%
%Grafik: FvsSTwitch
[~,T,qH1]=myHatze(7,1,0,11.25,4.4525,3);%m,rho_c,nu
[~,~,qH2]=myHatze(7,1,0,3.67,4.4525,3);

[~,~,qH3]=myHatze(7,0.1,0,11.25,4.4525,3);
[~,~,qH4]=myHatze(7,0.1,0,3.67,4.4525,3);

T=T(1:2001);
T=T.*1000;
qH1=qH1(1:2001);
qH2=qH2(1:2001);
qH3=qH3(1:2001);
qH4=qH4(1:2001);

plot(T,qH1,T,qH3,'LineWidth',1.7)
hold on
plot(T,qH2,'--',T,qH4,'--','LineWidth',1.7)
% legend('m=11','m=7.5','m=4')
xlabel('Zeit [ms]','Fontsize',19)
ylabel('normierte Kraft F','Fontsize',19)
set(gca,'Fontsize',19)
%%
%maximales �2 finden
m = models.motorunit.Shorten('SarcoVersion', 1);
m.System.f.LinkSarcoMoto=1;

mu = [1;10]

[t,y]=m.simulate(mu);
m.plot(t,y) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%Hatze
[signal,T,qH]=myHatze(106,1,0,11,4.4525,3);
% plot(T,qH,signal.Time,signal.Data);

%%
%Signal

signal = f_getSignal(7,0);

plot(signal.Time,signal.Data,'r','LineWidth',1.7);
ylim([0 1.1]);
xlim([0 2]);
ylabel('*maxStim');
xlabel('Zeit[s]');



%%
%Hatze mit force
isNorm=0;
constv=3;
constrho=4.4525;
constm=6.3977;
lCErel=0.5837;

    %fuer Normierung
    [~,~,q] = myHatze(6,1,0,constm,constrho,constv,lCErel);
    maxq=max(q);
    clear q;

    [signal,T,q,forceH]=myHatze(1,1,0,constm,constrho,constv,lCErel);
    
    if isNorm==1
        q = q./maxq;
    end
    
    hold on
    plot(T,q)
    legend('q')
% end
%%
%Hatze im Vergleich zu Shorten
%Testf�lle
clear all
%cfg:
figure;
data=7;
isNoise=1;
asc=0;
desc=0;

constv=2.0001;
constrho_C=-2.9927;
constm=9.7687;
constlCErel=1;
constlrho=2.9;
isNorm=0;

%fuer Normierung
[~,~,q]=myHatze(6,1,0,constm,constrho_C,constv,constlCErel,constlrho);
maxq=max(q);
clear q;

for n = 0:10
    %Shorten
    load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(data),...
        '_',num2str(n),'.mat'),'forces');
    forceS=f_myPool(forces);
    forceS=f_normShorten(forceS,isNoise);
    
    %Hatze
    if data==2 || data==4
        [~,T,q]=myHatze(data,1,n/10,constm,constrho_C,constv,constlCErel,constlrho);
%         [~,forceH,~]=myHatzePool(data,n/10)
    else
        [~,T,q]=myHatze(data,n/10,0,constm,constrho_C,constv,constlCErel,constlrho);
%         [~,forceH,~]=myHatzePool(data,n/10)
    end
    if isNorm==1
        q=q./maxq;%Normierung
    end
    
    forceS=forceS(1:2001);
    q=q(1:2001);
    T=T(1:2001);
    
    if asc==1
        forceS=forceS(1:911);
        q=q(1:911);
        T=T(1:911);
    end
    if desc==1
        forceS=forceS(911:end);
        q=q(911:end);
        T=T(911:end);
    end
%     figure;
    hold on
    plot(T,forceS,'g',T,q,'r')
    ylim([0 1.3])
    xlabel('t')
    ylabel('q')
    legend('Shorten','Hatze')    
end
%% 
%Signale
data=1:14;
isNoise=1;
% isNorm=1;

% constv=3;constm=5.7014;constrho_C=1.6316;%Allgemein

% constv=2;constm=4.8648;constrho_C=1.4740;%nur Afstieg
% constv=2;constm=8.7884;constrho_C=2.5005;
constv=3;constm=6.2430;constrho_C=2.0126; isNorm=0;

%fuer Normierung
[~,~,q]=myHatze(5,1,0,constm,constrho_C,constv);
maxq=max(q);
clear q;

 for n = data
    load(strcat('Shorten/preProcShorten_Noise',num2str(isNoise),'_signal',num2str(n),'.mat'));
    [signal,T,q]=myHatze(strcat('Shorten/Signal',num2str(n),'.mat'),1,0,constm,constrho_C,constv);
    force=f_myPool(forces);
    force=f_normShorten(force);
    if isNorm==1
        q=q./maxq;
    end
    
    signal.Data=signal.Data;%Fehlerfaktor korrigieren
    figure
    plot(signal.Time,signal.Data,'r',T,force,'g',T,q,'b')
    ylim([0 1]);
    legend('Signal','Shorten','Hatze')
 end
 
%%
%Hatze
for stim = 0:10
    [~,T,qH1]=myHatze(7,stim/10,0,11,4.4525,3);
    plot(T,qH1)
    hold on
end

%%
%Hatze Parameterspielerei
constv = 3;
constm=3.67;
constrho=4.4525;

for constm = 0:11
    [~,T,q]=myHatze(3,1,0,constm,constrho,constv);
    hold on
    plot(T,q)
end

%%
%Test Shorten
data=7

for n=1:10
isNoise=0;
load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(data),'_',num2str(n),'.mat'));
forceN0=f_myPool(forces);
forceN0=f_normShorten(forceN0,isNoise);

isNoise=1;
load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(data),'_',num2str(n),'.mat'));
forceN1=f_myPool(forces);
forceN1=f_normShorten(forceN1,isNoise);

hold on
plot(0:length(forceN0)-1,forceN0,0:length(forceN1)-1,forceN1)
legend('Noise Off','Noise On')
end
 %%
 %Vergleich HatzePool gegen Hatze
 [signal,T,force1]=myHatze(1,0.1,0,7.46,7.24,3);
 [~,force2,force3]=myHatzePool(1,0.1,7.24,3);
 
 plot(T,force1,T,force2)
 legend('single','pool')
 
%  plot(T,force1,T,force2,T,force3)
%  legend('single','pool','fugle')
 
%%
%Darstellung Pool Haatze
for ft=1:121
m(ft)=interp1([0,0.8,1],[3.67,12.1313,11.25],(ft-1)/120,'spline');
end
plot(0:1/120:1,m)

%%
%%
%test4lead
 maxStim=0.2;
 [signal,force,forces]=f_myShorten(4,0,maxStim);
 save(strcat('preProcShorten_1sOn_1sOff_NoiseOff-maxStim',num2str(maxStim),'.mat'));
 

%%
%maximum von Shorten finden
load(strcat('Eingang/pPS_Noise1_c3_10.mat'));
clear force;
force=f_myPool(forces);
max(force)
plot(force)

%%
%Shorten Pool testen (f_myPool anpassen)
load(strcat('Eingang/pPS_Noise0_c3_10.mat'));
clear force;
force20 = f_myPool(forces,20);
max20 = max(force20);
force20 = force20./max20;
force100 = f_myPool(forces,100);
max100 = max(force100);
force100 = force100./max100;

plot(0:4000,force20,0:4000,force100)
legend('20','100')

