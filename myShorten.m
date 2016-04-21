function [signal,force,forces]= myShorten(Data, isNoise, maxStim, minStim)
    signal=f_getSignal(Data,minStim);
    signal.Time = signal.Time*1000;
    signal.totalTime=signal.totalTime*1000;
    stim=@(t)(f_getStim(t,signal)*8.3603*maxStim);
%     stim=@(t)(f_getStim(t,signal)*10*maxStim);
    m=models.motorunit.Shorten('SarcoVersion',2);
    m.System.f.LinkSarcoMoto=1;
    m.UseNoise=isNoise;
    ng=m.System.noiseGen;
    m.System.Inputs{2}=stim;
    m.System.setConfig(m.DefaultMu,2);
    p=models.motorunit.Pool(2,m);
    p.FibreTypes=0:0.0083:1;
%     p.FibreTypes=0:1:1;
    [force,forces]=p.simulate(1,signal.totalTime,1);
end

function [stim]=f_getStim(t,s)
    stim=interp1(s.Time,s.Data,t);
end