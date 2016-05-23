function [CoV] = f_peakFinder_FT( stim, numMU, doPLOT )
    %CoV des iterstimulusinterval

    %init cfg
    cfg.isNoise=1;
    cfg.startt=10001;%Startzeit in [ms]
    cfg.stopt=14001;%Stopzeit in [ms]
    cfg.stim=stim;
    cfg.numMU=numMU;
    cfg.refTime=5; %Refraktärzeit, Zeit in der kein neues AP ausgelöst werden kann
    cfg.rborder=15;%recognition border firetimes
    
    %load data
    load(strcat('SO_firetimes_Stim',num2str(cfg.stim),'_Noise',num2str(cfg.isNoise),'.mat'));
    dataSet=firetimes;
   
    edges=f_findPeak(dataSet(cfg.numMU,cfg.startt:cfg.stopt),cfg.rborder,cfg.refTime);

    diffedges = zeros(1,length(edges)-1);

    %CoV berechnen
    for n=1:length(edges)-1
        diffedges(n)=edges(n+1)-edges(n);
    end
    s=std(diffedges);
    m=mean(diffedges);
    CoV=s/m*100;

    %plot.this.stuff
    if doPLOT==1
        plot(dataSet(cfg.numMU,cfg.startt:cfg.stopt),'r')
        hold on
        for n = 1 : length(edges)
            line([edges(n) edges(n)], [0 10])
        end
    end
end
    
function [edges] = f_findPeak( dataSet, rborder, refTime)
    signaltemp=dataSet(1:end-1);
    signaltempshifted=dataSet(2:end);

    edges=find(signaltemp>rborder & signaltempshifted<rborder); % falling edges
    %Doppeldetektionen vermeiden
    for n = 2 : length(edges)
        %Doppeldetektionen <refTime aus edges löschen
        if edges(n-1)>=edges(n)-refTime
            edges(n-1)=[];
        end
        if n >= length(edges)
            break;
        end
    end
end

