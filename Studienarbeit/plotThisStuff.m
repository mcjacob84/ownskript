%%
%Plot Standardsignale
%cfg:
Hatze=0;
data=4;
isNoise=0;
doprint=1;

isNorm=1;
constv=3;
constm=5.7014;
constrho_C=1.6316;

if Hatze==1
    fname='Hatze';
else
    fname='Shorten';
end

f = figure('Name',fname,'NumberTitle','off')
    
%fuer Normierung
[~,~,q]=myHatze(5,1,0,constm,constrho_C,constv);
maxq=max(q);
clear q;
    
for n = 0:9
    %Shorten
    load(strcat('Shorten/preProcShorten_Noise',num2str(isNoise),'_c',num2str(data),...
        '_',num2str(n),'.mat'),'forces');
    force=f_myPool(forces); 
    force=f_normShorten(force);
    
    %Hatze
    if data==2 || data==4
        [~,T,q]=myHatze(data,1,n/10,constm,constrho_C,constv);
    else
        [~,T,q]=myHatze(data,n/10,0,constm,constrho_C,constv);
    end
    if isNorm==1
        q=q./maxq;%Normierung
    end
    
    hold on
    if Hatze==1
        plot(T,q)
    else
        plot(T,force)
    end
    ylim([0 1.3])
    xlabel('t')
    ylabel('q')
    legend(fname)    
end
if doprint==1
    print(f,'-djpeg',strcat('PLOTS/',num2str(data),num2str(isNoise),fname));
end

%%
%Plot variable Stim
%cfg:
for data=1:14;
for isNoise=0:1;
doprint=1;

isNorm=1;
constv=3;
constm=5.7014;
constrho_C=1.6316;

f = figure('Name',strcat('signal',num2str(data)),'NumberTitle','off')
    
%fuer Normierung
[~,~,q]=myHatze(5,1,0,constm,constrho_C,constv);
maxq=max(q);
clear q;
    
    %Shorten
    load(strcat('Shorten/preProcShorten_Noise',num2str(isNoise),'_signal',num2str(data),'.mat'),'forces');
    force=f_myPool(forces); 
    force=f_normShorten(force);
    
    %Hatze
    [signal,T,q]=myHatze(strcat('Shorten/signal',num2str(data)),1,1,constm,constrho_C,constv);
    if isNorm==1
        q=q./maxq;%Normierung
    end
    
    plot(signal.Time,signal.Data.*1.1296,'r',T,q,'g',T,force,'b')
    ylim([0 1.3])
    xlabel('t')
    ylabel('q')
    legend('Stimulation','Hatze','Shorten')
if doprint==1
    print(f,'-djpeg',strcat('PLOTS/signal',num2str(data),num2str(isNoise)));
end
clear force;
clear forces;
clear q;
clear signal;
clear T;
end
end