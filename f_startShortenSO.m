function [force] = f_startShortenSO( data, isNoise, in )
% cd kermor/
% KerMor.start
% cd ..

switch data
    case 1
        disp(strcat('SO_c',num2str(data),'_N_', num2str(isNoise)));
        [signal,force,forces]=myShorten(data,isNoise,in,0);
        save(strcat('MA_SO_pPS_Noise',num2str(isNoise),'_c',num2str(data),'_',num2str(in),'.mat'));
    case 106
        disp(strcat('SO_c',num2str(data),'_N_', num2str(isNoise)));
        [signal,force,forces]=myShorten(data,isNoise,in,0);
        save(strcat('MA_SO_pPS_Noise',num2str(isNoise),'_c',num2str(data),'_',num2str(in),'.mat'));
    %{
    otherwise
        disp(data);
        [signal,force,forces]=myShorten(data,isNoise,in,0);
        save(strcat('pPS_Noise',num2str(isNoise),'_',num2str(data),'.mat'));
    %}
    end
        
end

function [signal,force,forces]= myShorten(Data, isNoise, maxStim, minStim)
    signal=f_getSignal(Data,minStim);
    signal.Time = signal.Time*1000;
    signal.totalTime=signal.totalTime*1000;
    stim=@(t)(f_getStim(t,signal)*8.3603*maxStim);
%     stim=@(t)(f_getStim(t,signal)*10*maxStim);
    m=models.motorunit.Shorten('SarcoVersion',1);
    m.System.f.LinkSarcoMoto=1;
    m.UseNoise=isNoise;
    ng=m.System.noiseGen;
    m.System.Inputs{2}=stim;
    m.System.setConfig(m.DefaultMu,2);
    p=models.motorunit.Pool(2,m);
%     p.FibreTypes=0:0.0083:1;
    p.FibreTypes=0:1:1;
    [force,forces]=p.simulate(1,signal.totalTime,1);
end

function [stim]=f_getStim(t,s)
    stim=interp1(s.Time,s.Data,t);
end
%%
%trasshcan
%{
%2sOns2Off
disp('Version3N_Off')
maxStim=in;
[signal,force,forces]=f_myShorten(6,0,maxStim);
save(strcat('preProcShorten_2sOn_2sOff_NoiseOFF_maxStim',num2str(maxStim),'.mat'));
%}