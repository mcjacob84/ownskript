function [signal,force,forces, tmp_t, y, tmp_sec, tmp_x]= f_startShortenSO(Data, isNoise, maxStim, minStim, form1, form2)
    
    signal=f_getSignal(Data,minStim);
    signal.Time = signal.Time*1000;
    signal.totalTime=signal.totalTime*1000;
%     stim=@(t)(f_getStim(t,signal)*8.3603*maxStim); %maxMU=0.996
    stim=@(t)(f_getStim(t,signal)*8.4437*maxStim); %maxMU=1
    m=models.motorunit.Shorten(form1, form2,'SarcoVersion',1); %opt_Param
    m.System.f.LinkSarcoMoto=1;
    m.UseNoise=isNoise;
    ng=m.System.noiseGen;
    m.System.Inputs{2}=stim;
    m.System.setConfig(m.DefaultMu,2);
    
    p=models.motorunit.Pool(2,m);
%     p.FibreTypes=[0:120].*1/120; %121 Muskelfasern
    p.FibreTypes=[0 60 120].*1/120; %3 Muskelfasern
    
    [force,forces,tmp_t,y,tmp_sec,tmp_x]=p.simulate(1,signal.totalTime,1);
    %(meancurrent,Time,dt)
    %Warum meancurrent=1? Ist hier egal, da auch anderen inputindex und
    %somit auf anderes Stim bezogen wird???
end