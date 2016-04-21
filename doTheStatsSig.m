%%
%Statistik der Signale
showFig='off';
isNoise=1;

for data=1:14;
doprint=1;

v_R=3;rho_C_R=4.4525;m_R=11.3;%funName='Rockenfellerad'
v_A=4.613;rho_C_A=1.9068;m_A=5.2857;%funName='allfreead'

%f = figure('Name',strcat('signal',num2str(data)),'NumberTitle','off','Visible',showFig)
   
    %Shorten
    load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_signal',num2str(data),'.mat.mat'),'forces');
    force=f_myPool(forces); 
    force=f_normShorten(force,isNoise);
    
    %Hatze
    [signal,T,q_R,~]=myHatze(strcat('Eingang/signal',num2str(data),'.mat'),1,1,m_R,rho_C_R,v_R);
    [~,~,q_A,~]=myHatze(strcat('Eingang/signal',num2str(data),'.mat'),1,1,m_A,rho_C_A,v_A);
    
    err_R=abs(bsxfun(@minus,q_R,force));
    err_A=abs(bsxfun(@minus,q_A,force));
    
    force_Short(data,:)=force;
    q_Rock(data,:)=q_R;
    q_All(data,:)=q_A;
    signal_Save(data,:)=signal;
    
    %step1:ueber einzelne sigma
        stats_m_R=mean(err_R)
        stats_s_R=std(err_R)
        
        stats_m_A=mean(err_A)
        stats_s_A=std(err_A)
        
%         posq=f_findPos(q);
%         posforce=f_findPos(force);
%         timeconst=(posq-posforce);
    
        %step2: an jedem Punkt
%         stats_m2=mean(err);
%         stats_s2=std(err);
        
        %step3: gesamt
%         stats_m3=mean(stats_m1);%Mittelwert ueber Mittelwert?
%         stats_s3=std(stats_s1);
        %Kontrolle
%         err2=reshape(err,1,[]);
%         stats_m4=mean(err2);
%         stats_s4=std(err2);
%         clear err2;
        
        %step4: Zeitkonst
%         stats_m5=mean(timeconst);
%         stats_s5=std(timeconst);

%Figures
%Signal
fname='Signal';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
set(f,'Position',[0,0,600,100])
hold on
plot(T,q_R,'g--','LineWidth',1.7)
plot(T,q_A,'g','LineWidth',1.7)
plot(signal.Time,signal.Data,'r--','LineWidth',1.7)
plot(T,force,'b--','LineWidth',1.7)
legend('phModell Rockenfeller','phModell allvar','Signal','bpModell')
ylim([0 1])
print(f,'-djpeg',strcat('PLOTS/Signale/signal',num2str(data),num2str(isNoise),fname));

%Errorbar(Fehler ueber Sigma)        
fname='Errorbars_R';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
errorbar(stats_m_R,stats_s_R,'x')
print(f,'-djpeg',strcat('PLOTS/Signale/signal',num2str(data),num2str(isNoise),fname));

fname='Errorbars_A';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
errorbar(stats_m_A,stats_s_A,'x')
print(f,'-djpeg',strcat('PLOTS/Signale/signal',num2str(data),num2str(isNoise),fname));

%Boxplot(Fehler ueber Sigma)
%{
fname='Boxplots';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
boxplot(err') 
print(f,'-djpeg',strcat('PLOTS/signal',num2str(data),num2str(isNoise),fname));
%}

%Fehler ueber Zeit
%{
fname='ErrOverTime';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
for n=0:0.001:1
    hold on
    plot(0:length(stats_m2)-1,stats_m2+n*stats_s2,'r')
    plot(0:length(stats_m2)-1,stats_m2-n*stats_s2,'r')
end
plot(0:length(stats_m2)-1,stats_m2,'k','LineWidth',2)
print(f,'-djpeg',strcat('PLOTS/signal',num2str(data),num2str(isNoise),fname));
%}

%Errorbar (Gesamt?)
%{
fname='ErrorbarALL';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
errorbar(stats_m3,stats_s3,'x')
print(f,'-djpeg',strcat('PLOTS/signal',num2str(data),num2str(isNoise),fname));
%}

%Zeitkonstante
%{
fname='Timeconsts';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
plot(1:10,timeconst)
print(f,'-djpeg',strcat('PLOTS/signal',num2str(data),num2str(isNoise),fname));
%}

%Zeitkonsnstante mean
%{
fname='TimeconstALL';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
errorbar(stats_m5,stats_s5,'x')
print(f,'-djpeg',strcat('PLOTS/signal',num2str(data),num2str(isNoise),fname));
%}

clear err;
clear force;
clear forces;
clear posforce;
clear posq;
clear q;
clear stats_m1;
clear stats_s1;
clear stats_m2;
clear stats_s2;
clear stats_m3;
clear stats_s3;
clear stats_m4;
clear stats_s4;
clear stats_m5;
clear stats_s5;
clear timeconst;
close all;
end

fname='Signal';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
for n=1:4
    subplot(4,1,n)
    hold on
    plot(T,q_Rock(n,:),'--',T,force_Short(n,:),'LineWidth',1.7)
    plot(T,q_All(n,:),'LineWidth',1.7)
    plot(signal_Save(n).Time,signal_Save(n).Data,'r','LineWidth',1.7)
%     legend('phModell Rockenfeller','bpModell','phModell allvar','Signal')
    ylim([0 1])
end
print(f,'-djpeg',strcat('PLOTS/Signale/signal1to4',num2str(isNoise),fname));

fname='Signal';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
for n=5:7
    subplot(3,1,n-4)
    hold on
    plot(T,q_Rock(n,:),'--',T,force_Short(n,:),'LineWidth',1.7)
    plot(T,q_All(n,:),'LineWidth',1.7)
    plot(signal_Save(n).Time,signal_Save(n).Data,'r','LineWidth',1.7)
%     legend('phModell Rockenfeller','bpModell','phModell allvar','Signal')
    ylim([0 1])
end
print(f,'-djpeg',strcat('PLOTS/Signale/signal5to7',num2str(isNoise),fname));

fname='Signal';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
for n=8:11
    subplot(4,1,n-7)
    hold on
    plot(T,q_Rock(n,:),'--',T,force_Short(n,:),'LineWidth',1.7)
    plot(T,q_All(n,:),'LineWidth',1.7)
    plot(signal_Save(n).Time,signal_Save(n).Data,'r','LineWidth',1.7)
%     legend('phModell Rockenfeller','bpModell','phModell allvar','Signal')
    ylim([0 1])
end
print(f,'-djpeg',strcat('PLOTS/Signale/signal8to11',num2str(isNoise),fname));

fname='Signal';
f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
for n=12:14
    subplot(3,1,n-11)
    hold on
    plot(T,q_Rock(n,:),'--',T,force_Short(n,:),'LineWidth',1.7)
    plot(T,q_All(n,:),'LineWidth',1.7)
    plot(signal_Save(n).Time,signal_Save(n).Data,'r','LineWidth',1.7)
%     legend('phModell Rockenfeller','bpModell','phModell allvar','Signal')
    ylim([0 1])
end
print(f,'-djpeg',strcat('PLOTS/Signale/signa12to14',num2str(isNoise),fname));
% 
% fname='Signal';
% f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
% for n=11:12
%     subplot(2,1,n-10)
%     hold on
%     plot(T,q_Rock(n,:),'--',T,force_Short(n,:),'LineWidth',1.7)
%     plot(T,q_All(n,:),'LineWidth',1.7)
%     plot(signal_Save(n).Time,signal_Save(n).Data,'r','LineWidth',1.7)
% %     legend('phModell Rockenfeller','bpModell','phModell allvar','Signal')
%     ylim([0 1])
% end
% print(f,'-djpeg',strcat('PLOTS/Signale/signal11to12',num2str(isNoise),fname));
% 
% fname='Signal';
% f = figure('Name',fname,'NumberTitle','off','Visible',showFig)
% for n=13:14
%     subplot(2,1,n-12)
%     hold on
%     plot(T,q_Rock(n,:),'--',T,force_Short(n,:),'LineWidth',1.7)
%     plot(T,q_All(n,:),'LineWidth',1.7)
%     plot(signal_Save(n).Time,signal_Save(n).Data,'r','LineWidth',1.7)
% %     legend('phModell Rockenfeller','bpModell','phModell allvar','Signal')
%     ylim([0 1])
% end
% print(f,'-djpeg',strcat('PLOTS/Signale/signal13to14',num2str(isNoise),fname));