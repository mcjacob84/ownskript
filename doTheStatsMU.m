% for n = 1:14
% signal=strcat('signal',num2str(n));
for signal=7:7;

showFig = 'off';
isNoise=1;
for maxStim=0:10

isNorm=0;constv=3;constrho_C=4.4525;constm=11.3;asc=0;desc=0;funName='Rockenfellerad'
% isNorm=0;constv=4.613;constrho_C=1.9068;constm=5.2857;asc=0;desc=0;funName='allfreead'

%load data
if ischar(signal)
    load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_',signal,'.mat.mat'),'forces');
    mkdir(strcat('PLOTS/numMU/',funName,'/',signal,'/'))
    println=strcat('PLOTS/numMU/',funName,'/',signal,'/');
else
    load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(signal),...
        '_',num2str(maxStim),'.mat'),'forces');
    mkdir(strcat('PLOTS/numMU/c',funName,'/',num2str(signal),'/',num2str(maxStim),'/'))
    println=strcat('PLOTS/numMU/c',funName,'/',num2str(signal),'/',num2str(maxStim),'/',...
        num2str(signal),num2str(isNoise));
end
    
[~,T,q,~]=myHatze(signal,maxStim/10,0,constm,constrho_C,constv);

forces2=forces(1:120:121,1:911);
forces3=forces(1:60:121,1:911);
forces4=forces(1:40:121,1:911);
forces5=forces(1:30:121,1:911);
forces7=forces(1:20:121,1:911);
forces9=forces(1:15:121,1:911);
forces11=forces(1:12:121,1:911);
forces13=forces(1:10:121,1:911);
forces16=forces(1:8:121,1:911);
forces21=forces(1:6:121,1:911);
forces25=forces(1:5:121,1:911);
forces31=forces(1:4:121,1:911);
forces41=forces(1:3:121,1:911);
forces61=forces(1:2:121,1:911);
forces121=forces(1:1:121,1:911);

force(1,:)=f_normShorten2(forces2,2);
force(2,:)=f_normShorten2(forces3,3);
force(3,:)=f_normShorten2(forces4,4);
force(4,:)=f_normShorten2(forces5,5);
force(5,:)=f_normShorten2(forces7,7);
force(6,:)=f_normShorten2(forces9,9);
force(7,:)=f_normShorten2(forces11,11);
force(8,:)=f_normShorten2(forces13,13);
force(9,:)=f_normShorten2(forces16,16);
force(10,:)=f_normShorten2(forces21,21);
force(11,:)=f_normShorten2(forces25,25);
force(12,:)=f_normShorten2(forces31,31);
force(13,:)=f_normShorten2(forces41,41);
force(14,:)=f_normShorten2(forces61,61);
force(15,:)=f_normShorten2(forces121,121);

numberMUs=[2,3,4,5,7,9,11,13,16,21,25,31,41,61,121];

    q=q(:,1:911);
    T=T(:,1:911);

for n = 1:15
    fname='Figure'
    f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
        plot(T,force(n,:),T,q)
        xlabel('Zeit [ms]')
        ylabel('normierte Aktivität')
        legend('bpModell','phModell')
%         xlim([0 1])
        ylim([0,1])
        print(f,'-djpeg',strcat(println,fname,'_',num2str(numberMUs(n))));
end

%Fehler berechnen
for n = 1:15
    err(n,:)=abs(bsxfun(@minus,force(n,:),q(1,:)));
    stats_m(n)=mean(err(n,:));
    stats_s(n)=std(err(n,:));
end

stats_s2=std(stats_m(:));

fname='Errorbars'
    f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
    hold on
    plot([1 1000],[stats_m(15) stats_m(15)],'r','LineWidth',1.7)
    plot([1 1000],[stats_m(15)+stats_s2 stats_m(15)+stats_s2],'--r','LineWidth',1.7)
    plot([1 1000],[stats_m(15)-stats_s2 stats_m(15)-stats_s2],'--r','LineWidth',1.7)
    errorbar(numberMUs',stats_m',stats_s','x','LineWidth',1.7)    
    set(gca,'xscale','log')
    set(gca,'Fontsize',19)
    xlabel('#MU')
    ylabel('err')
    suptitle(strcat('Stim = ', num2str(maxStim/10)))
    print(f,'-djpeg',strcat(println,fname,'_',num2str(maxStim)));
end


close all
clear all
clc
end