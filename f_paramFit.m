function [CoV]=f_paramFit()
cd kermor/
KerMor.start
cd ..      

    %Ergebnis in Matrix eintragen
    for param = 1
        CoV(round(param*10)+1) = paramFit(param);
    end
    save(strcat('CoV_FreeParam_SON1F0_c106_stim0.1.mat'));
end

function [CoV] = paramFit(param)
    %Parameterfit of free Prameter is Noise generation
       
    %Shorten erzeugen
    [~,~,forces,~,~,~,tmp_x]=myShorten(param)
    mfpot=tmp_x{7}(1,10001:14001);
       
    %nächste Schritte
     
    %CoV ISI berechnen
    %Muskelfaserpotential nehmen
    CoV=f_peakFinder_mfpot(mfpot);
     
    %Distanz zu 15% grafisch darstellen
    %Wenn sich Optimum eistellt, eventuell sogar bei 15%
    %Dann schauen, wie sich Wert auf retliche MF auswirkt.
    %Und restliche stim
end

function [signal,force,forces, tmp_t, y, tmp_sec, tmp_x]= myShorten(param)

%cfg
maxStim=0.1;
minStim=0;
isNoise=1;
Data=106;
fibreType=0.1;

    signal=f_getSignal(Data,minStim);
    signal.Time = signal.Time*1000;
    signal.totalTime=signal.totalTime*1000;
    stim=@(t)(f_getStim(t,signal)*8.3603*maxStim);
    m=models.motorunit.Shorten(param,'SarcoVersion',1);
    m.System.f.LinkSarcoMoto=1;
    m.UseNoise=isNoise;
    ng=m.System.noiseGen;
    m.System.Inputs{2}=stim;
    m.System.setConfig(m.DefaultMu,2);
    p=models.motorunit.Pool(2,m); %Pooltype, 2 for Shorten
    p.FibreTypes=fibreType; %Fibretypes
    [force,forces,tmp_t,y,tmp_sec,tmp_x]=p.simulate(1,signal.totalTime,1);
    
end

function [stim]=f_getStim(t,s)
    stim=interp1(s.Time,s.Data,t);
end

function [CoV] = f_peakFinder_mfpot( dataSet )
    %CoV des iterstimulusinterval

    %init cfg
    cfg.refTime=5; %Refraktärzeit, Zeit in der kein neues AP ausgelöst werden kann
    cfg.rborder=-50; %recognition border mfpot
 
    edges=f_findPeak(dataSet(1,:),cfg.rborder,cfg.refTime);

    diffedges = zeros(1,length(edges)-1);

    %CoV berechnen
    for n=1:length(edges)-1
        diffedges(n)=edges(n+1)-edges(n);
    end
    s=std(diffedges);
    m=mean(diffedges);
    CoV=s/m*100;
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