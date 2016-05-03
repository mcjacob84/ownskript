%Skript to read out firetimes of States ("tmp_x")

%cfg
isNoise=0;

for stim =0:0.01:0.4
    %load data
    load(strcat('MA_SO_pPS_Noise',num2str(isNoise),'_c106_', num2str(stim),'.mat'));
    
    %init firetimes
    firetimes=zeros(121,20001);
    %read out firetimes
    for n=1:121
        firetimes(n,:)=tmp_x{n}(2,:);
    end
    
    %save firetimes to file
    save(strcat('SO_firetimes_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'firetimes');
    
    %save forces
    save(strcat('SO_forces_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'forces');
end

for stim =0.5:0.1:1
    %load data
    load(strcat('MA_SO_pPS_Noise',num2str(isNoise),'_c106_', num2str(stim),'.mat'));
    
    %init firetimes
    firetimes=zeros(121,20001);
    %read out firetimes
    for n=1:121
        firetimes(n,:)=tmp_x{n}(2,:);
    end
    
    %save firetimes to file
    save(strcat('SO_firetimes_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'firetimes');
    
    %save forces
    save(strcat('SO_forces_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'forces');
end