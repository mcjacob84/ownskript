function [force] = f_startShortenSO( data, isNoise, in )
% cd kermor/
% KerMor.start
% cd ..

disp(strcat('SO_c',num2str(data),'_N_', num2str(isNoise),'+ALLSTATES'));
[signal,force,forces, tmp_t, y, tmp_sec, tmp_x]=myShorten(data,isNoise,in,0);
save(strcat('MA_SO_pPS_Noise',num2str(isNoise),'_c',num2str(data),'_',num2str(in),'.mat'));
     
end

function [signal,force,forces, tmp_t, y, tmp_sec, tmp_x]= myShorten(Data, isNoise, maxStim, minStim)
    signal=f_getSignal(Data,minStim);
    signal.Time = signal.Time*1000;
    signal.totalTime=signal.totalTime*1000;
    stim=@(t)(f_getStim(t,signal)*8.3603*maxStim);
    m=models.motorunit.Shorten(1.2,'SarcoVersion',1);
    m.System.f.LinkSarcoMoto=1;
    m.UseNoise=isNoise;
    ng=m.System.noiseGen;
    m.System.Inputs{2}=stim;
    m.System.setConfig(m.DefaultMu,2);
    p=models.motorunit.Pool(2,m);
    p.FibreTypes=0.1; %Fibretypes
    [force,forces,tmp_t,y,tmp_sec,tmp_x]=p.simulate(1,signal.totalTime,1);
end

function [stim]=f_getStim(t,s)
    stim=interp1(s.Time,s.Data,t);
end