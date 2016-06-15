%% Skript um f_peakFinder_FT oder f_peakFinder_mfpot auszuführen

% GEÄNDERT: 03. Juni 2016
% Neue Version sollte alles in einfacherer Struktur implementiert haben
% Test steht noch aus!

function [CoV] = peakFinder 
    
    %cfg
    cfg.type=2; % 1 for FT = Motoneuron, 2 for mfpot = Musclefibrepot
    cfg.stim=0.1;
    cfg.numMU=32;
    cfg.doPlot=1;
    
    CoV = zeros(47,121);

    for stim=1:length(cfg.stim)
        for numMU=1:length(cfg.numMU)
            CoV(stim, numMU)=f_peakFinder(cfg.stim(stim),cfg.numMU(numMU),cfg.doPlot,cfg.type);
        end
    end

end

function [CoV] = f_peakFinder(stim, numMU, doPLOT, isType )
    %CoV des iterstimulusinterval

    %init cfg
    cfg.isNoise=1;
    cfg.startt=10001;%Startzeit in [ms]
    cfg.stopt=14001;%Stopzeit in [ms]
    cfg.stim=stim;
    cfg.numMU=numMU;
    cfg.refTime=5; %Refraktärzeit, Zeit in der kein neues AP ausgelöst werden kann
    
    if isType == 1
        cfg.rborder=15;%recognition border firetimes
        cfg.loadString='firetimes';
    else
        cfg.rborder=-50; %recognition border mfpot
        cfg.loadString='mfpot';
    end
    
    %load data
    load(strcat('SO_',cfg.loadString,'_Stim',num2str(cfg.stim),'_Noise',num2str(cfg.isNoise),'.mat'));
    dataSet=eval(cfg.loadString);
   
    [edges,diffedges]=f_findPeak(dataSet(cfg.numMU,cfg.startt:cfg.stopt),cfg.rborder,cfg.refTime);

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



%% %%%%%%%% %%
%% TRASHCAN %%
%% %%%%%%%% %%
%% Skript for peak-detection to get ISI
% mfpot = Muskelfaser-Potential
% Kann durch neue Variablere Methode gelösct werden?
%{
function [CoV] = f_peakFinder_mfpot( stim, numMU, doPLOT )
    %CoV des iterstimulusinterval

    %init cfg
    cfg.isNoise=1;
    cfg.startt=10001;%Startzeit in [ms]
    cfg.stopt=14001;%Stopzeit in [ms]
    cfg.stim=stim;
    cfg.numMU=numMU;
    cfg.refTime=5; %Refraktärzeit, Zeit in der kein neues AP ausgelöst werden kann
    
    %load data
    load(strcat('SO_mfpot_Stim',num2str(cfg.stim),'_Noise',num2str(cfg.isNoise),'.mat'));
    dataSet=mfpot;
   
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
    
function [edges] = f_findPeak( dataSet, rborder, refTime ) 
    signaltemp=dataSet(1:end-1);
    signaltempshifted=dataSet(2:end);

    edges=find(signaltemp>rborder & signaltempshifted<rborder); % falling edges
    
     for n = 2 : length(edges)
        %Doppeldetektionen <refTime aus edges löschen
        if edges(n-1)>=edges(n)-refTime
            edges(n-1)=[];
        end
        if n == length(edges)
            break;
        end
    end
end
%}
