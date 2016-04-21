%%
%funktioniert, Statistik der einzelnen Versuche, unten gesamt
showFig='off';

for data=8:8
    if data==5 || data==6
        %do nothing
    else
    for isNoise = 0:1

% % % % %  
    %cfg

%     isNorm=0;constv=3;constrho_C=4.4525;constm=11.3;asc=0;desc=0;funName='Rockenfellerad'
    isNorm=0;constv=4.613;constrho_C=1.9068;constm=5.2857;asc=0;desc=0;funName='allfreead'
  
% % % % %



%     isNorm=0;constv=3;constrho_C=4.4525;constm=11.930;asc=0;desc=0;funName='Rockenfellerad'
%     isNorm=0;constv=3;constrho_C=4.4525;constm=1.8079;asc=1;desc=0;funName='Rockenfellera'
%     isNorm=0;constv=3;constrho_C=4.4525;constm=12.2868;asc=0;desc=1;;funName='Rockenfellerd'

%     isNorm=0;constv=2;constrho_C=9.1;constm=17.6125;asc=0;desc=0;funName='Hatze2ad'
%     isNorm=0;constv=2;constrho_C=9.1;constm=0.9730;asc=1;desc=0;funName='Hatze2a'
%     isNorm=0;constv=2;constrho_C=9.1;constm=18.1742;asc=0;desc=1;funName='Hatze2d'

%     isNorm=0;constv=3;constrho_C=7.24;constm=15.7181;asc=0;desc=0;funName='Hatze3ad'
%     isNorm=0;constv=3;constrho_C=7.24;constm=1.0084;asc=1;desc=0;funName='Hatze3a'
%     isNorm=0;constv=3;constrho_C=7.24;constm=16.3750;asc=0;desc=1;funName='Hatze3d'

%     isNorm=0;constv=4.6069;constrho_C=1.9076;constm=5.28;asc=0;desc=0;funName='allfreead'
%     isNorm=0;constv=;constrho_C=;constm=;asc=1;desc=0;funName='allfreea'
%     isNorm=0;constv=;constrho_C=;constm=;asc=0;desc=1;funName='allfreed'

% % % % %    

%     isNorm=0;constv=5.4744;constrho_C=1.8755;constm=5.3324;funName='allfree'
%     isNorm=1;constv=2.73;constrho_C=1.52;constm=5.93;funName='allfreenewNorm'    

% % % % %
    %fuer Normierung
    [signal,T,q,~]=myHatze(6,1,0,constm,constrho_C,constv);
    maxq=max(q);
    clear q;

    fname='Signal';
    f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
        
    for n=0:10
        %Shorten laden
        load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(data),...
            '_',num2str(n),'.mat'),'forces');
        force=f_myPool(forces); 
        force=f_normShorten(force,isNoise);
        
        %Hatze laden
        switch data
            case 1
                [signal,T,q]=myHatze(data,n/10,0,constm,constrho_C,constv);
            case 2
                [signal,T,q]=myHatze(data,1,n/10,constm,constrho_C,constv);
            case 3
                [signal,T,q]=myHatze(data,n/10,0,constm,constrho_C,constv);
                T=T(1:3501);q=q(1:3501);force=force(1:3501);signal.Time(4)=3.5;
            case 4
                [signal,T,q]=myHatze(data,1,n/10,constm,constrho_C,constv);
                T=T(1500:end);q=q(1500:end);force=force(1500:end);signal.Time(1)=1.5;
            case 7
                [signal,T,q]=myHatze(data,n/10,0,constm,constrho_C,constv);
                T=T(1:2001);q=q(1:2001);force=force(1:2001);signal.Time(4)=2;
            case 8
                [signal,T,q]=myHatze(data,1,n/10,constm,constrho_C,constv);
                T=T(901:4001);q=q(901:4001);force=force(901:4001);signal.Time(1)=0.9;
        end
        if isNorm==1
            q=q./maxq;
        end
        if asc==1
            force=force(1:911);
            q=q(1:911);
            T=T(1:911);
        end
        if desc==1
            force=force(911:end);
            q=q(911:end);
            T=T(911:end);
        end
        
        %Figure
        %Signal
        hold on
        T=T.*1000;
        plot(T,q,T,force,'LineWidth',1.7)
        legend('PH-Modell','BP-Modell')
%         text(signal.Time(2),max(force),num2str(n/10),'color','r')
%         text(signal.Time(2),max(q),num2str(n/10),'color','g')
        ylim([0 1.1])
        xlabel('Zeit [ms]','Fontsize',19)
        ylabel('normierte Kraft F','Fontsize',19)
        set(gca,'Fontsize',19)
        print(f,'-djpeg',strcat('PLOTS/',funName,'/',num2str(data),num2str(isNoise),fname));
        
        %Fehler berechnen
        err(n+1,:)=abs(bsxfun(@minus,q,force));
        
        %step1:ueber einzelne sigma
        stats_m1(n+1,:)=mean(err(n+1,:));
        stats_s1(n+1,:)=std(err(n+1,:));        
        
        posq=f_findPos(q);
        posforce=f_findPos(force);
        timeconst(n+1)=(posq-posforce);
    end
    
        %step2: an jedem Punkt
        stats_m2=mean(err);
        stats_s2=std(err);
        
        %step3: gesamt
        stats_m3=mean(stats_m1);%Mittelwert ueber Mittelwert?
        stats_s3=std(stats_s1);
        %Kontrolle
        err2=reshape(err,1,[]);
        stats_m4=mean(err2);
        stats_s4=std(err2);
        clear err2;
        
        %step4: Zeitkonst
        stats_m5=mean(timeconst);
        stats_s5=std(timeconst);

%Figures

%{
%Boxplot(Fehler ueber Sigma)
fname='Boxplots'
f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
boxplot(err') 
print(f,'-djpeg',strcat('PLOTS/',funName,'/',num2str(data),num2str(isNoise),fname));
%}

%Errorbar(Fehler ueber Sigma)        
fname='Errorbars'
f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
errorbar(0:0.1:1,stats_m1,stats_s1,'x','LineWidth',1.7)
xlabel('normierte neuronale Stimulation \sigma','Fontsize',19)
ylabel('err','Fontsize',19)
set(gca,'Fontsize',19)
xlim([0 1])
print(f,'-djpeg',strcat('PLOTS/',funName,'/',num2str(data),num2str(isNoise),fname));


%Errorbar (Gesamt?)
%nur für Text
fname='ErrorbarALL'
f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
errorbar(stats_m3,stats_s3,'x','LineWidth',1.7)
text(1,0,strcat('Mittelwert gesamt: ',num2str(stats_m3),' | Standardabweichung gesamt: ',num2str(stats_s3)))
print(f,'-djpeg',strcat('PLOTS/',funName,'/',num2str(data),num2str(isNoise),fname));


%Fehler ueber Zeit
fname='ErrOverTime'
f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
hold on
if data==7
    plot(0:length(stats_m2)-1,stats_m2+n*stats_s2,'r','LineWidth',1.7)
    plot(0:length(stats_m2)-1,stats_m2-n*stats_s2,'r','LineWidth',1.7)
    plot(0:length(stats_m2)-1,stats_m2,'k','LineWidth',2,'LineWidth',1.7)
elseif data==8
    plot(900:900+length(stats_m2)-1,stats_m2+n*stats_s2,'r','LineWidth',1.7)
    plot(900:900+length(stats_m2)-1,stats_m2-n*stats_s2,'r','LineWidth',1.7)
    plot(900:900+length(stats_m2)-1,stats_m2,'k','LineWidth',2,'LineWidth',1.7)
end    
xlabel('Zeit [ms]','Fontsize',19)
ylabel('err','Fontsize',19)
set(gca,'Fontsize',19)
print(f,'-djpeg',strcat('PLOTS/',funName,'/',num2str(data),num2str(isNoise),fname));
    
%Zeitkonstante
fname='Timeconsts'
f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
plot(0:0.1:1,timeconst,'o','LineWidth',1.7)
xlabel('normierte neuronale Stimulation \sigma','Fontsize',19)
ylabel('\Delta t [ms]','Fontsize',19)
set(gca,'Fontsize',19)
print(f,'-djpeg',strcat('PLOTS/',funName,'/',num2str(data),num2str(isNoise),fname));

%{
%---System Stuerzt ab?
%Zeitkonsnstante mean 
%(nur für Txt)
fname='TimeconstALL'
f = figure('Name',fname,'NumberTitle','off','Visible',showFig);
errorbar(stats_m5,stats_s5,'x','LineWidth',1.7)
text(1,0,strcat('Mittelwert gesamt: ',num2str(stats_m5),' | Standardabweichung gesamt: ',num2str(stats_s5)))
print(f,'-djpeg',strcat('PLOTS/',funName,'/',num2str(data),num2str(isNoise),fname));
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
    end
    end
end
close all
clear all
clc

%%
%cfg
%Gesamte STATISTIK Funzt noch nicht!!!
%unnötig?
for data = 1:4
    for isNoise = 0:0

isNorm=1;
constv=3;
constm=5.7014;
constrho_C=1.6316;


%fuer Normierung
[~,~,q]=myHatze(5,1,0,constm,constrho_C,constv);
maxq=max(q);
clear q;

    for n=0:9
        %Shorten laden
        load(strcat('Shorten/preProcShorten_Noise',num2str(isNoise),'_c',num2str(data),...
            '_',num2str(n),'.mat'),'forces');
        force=f_myPool(forces); 
        force=f_normShorten(force);
        
        %Hatze laden
        [~,~,q]=myHatze(data,n/9,0,constm,constrho_C,constv);
        if isNorm==1
            q=q./maxq;
        end
        %Fehler berechnen
        err{data,isNoise+1}{1,1}(n+1,:)=bsxfun(@minus,force,q);
        
        %step1:ueber einzelne sigma
        stats_m{data,isNoise+1}{1,1}(n+1,:)=mean(err{data,isNoise+1}{1,1}(n+1,:));
        stats_s{data,isNoise+1}{1,1}(n+1,:)=std(err{data,isNoise+1}{1,1}(n+1,:));        
        
        posq=f_findPos(q);
        posforce=f_findPos(force);
        timeconst{data,isNoise+1}{1,1}(n+1)=(posq-posforce);
    end
    
        %step2: an jedem Punkt
        stats_m{data,isNoise+1}{2,1}=mean(err{data,isNoise+1}{1,1});
        stats_s{data,isNoise+1}{2,1}=std(err{data,isNoise+1}{1,1});
        
        %step3: gesamt
        stats_m{data,isNoise+1}{3,1}=mean(stats_m{data,isNoise+1}{1,1});%Mittelwert ueber Mittelwert?
        stats_s{data,isNoise+1}{3,1}=std(stats_s{data,isNoise+1}{1,1});
        %Kontrolle
        err2=reshape(err{data,isNoise+1}{1,1},1,[]);
        stats_m{data,isNoise+1}{4,1}=mean(err2);
        stats_s{data,isNoise+1}{4,1}=std(err2);
        clear err2;
        
        %step4: Zeitkonst
        stats_m{data,isNoise+1}{5,1}=mean(timeconst{data,isNoise+1}{1,1});
        stats_s{data,isNoise+1}{5,1}=std(timeconst{data,isNoise+1}{1,1});

    end
end
        %{               
errorbar(stats_m{2},stats_s{2})

boxplot(err') 

for n=0:0.001:1
    hold on
    plot(0:length(stats_m{1})-1,stats_m{1}+n*stats_s{1},'r')
    plot(0:length(stats_m{1})-1,stats_m{1}-n*stats_s{1},'r')
end
plot(0:length(stats_m{1})-1,stats_m{1},'k','LineWidth',2)
    
errorbar(stats_m{3},stats_s{3})
        
%Zeitkonstante
errorbar(stats_m{5},stats_s{5})
%}        