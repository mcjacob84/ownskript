function [edges] = f_findPeak( firetimes )

    %cfg
    rborder=15; %recognition border
    
    signaltemp=firetimes(1:end-1);
    signaltempshifted=firetimes(2:end);

    edges=find(signaltemp>rborder & signaltempshifted<rborder); % falling edges
    
end
%{
times{MU}=tt(edges); % this saves only the first point of the spike, rather than the whole spike
ISI=diff(times{MU})
%}
%%
%{
%cfg
isNoise=1;
isSignal=106;
numMU=1; %nachher Schleife

%load data (dauert lange!)
% load (strcat('c:/Users/Marc/Desktop/res_MA/MA_SO_pPS_Noise1_c106_0.1.mat'),'tmp_x');

%Verarbeitung
firetimes=tmp_x{numMU}(2,15001:16001);

%Detrend mit Bandpass (Buterworth-Filter)
f1=4; %cuttoff low frequency to get rid of baseline wander
f2=60; %cuttoff frequency to discard high frequency noise
Wn=[f1 f2]*2/1000; % cutt off based on fs=1000Hz
N = 3; % order of 3 less processing
[a,b] = butter(N,Wn); %bandpass filtering
ecg_bf = filtfilt(a,b,ecg_raw);
ecg_bf = ecg_bf/ max(abs(ecg_bf));



%Verarbeitetes Signal darstellen
plot(firetimes);
%}

%%
%trashcan
%Algorithmus von Thomas!
%{
    signaltemp=yt(1:end-1);
    signaltempshifted=yt(2:end);
    edges=find(signaltemp>50 & signaltempshifted<50); % falling edges
    times{MU}=tt(edges); % this saves only the first point of the spike, rather than the whole spike
    ISI=diff(times{MU})
%}