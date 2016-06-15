%% Skript to read out firetimes of States ("tmp_x")

%cfg
useData='SO';
isNoise=1;

for stim =0:0.01:0.4
    %load data
    load(strcat('MA_',useData,'_pPS_Noise',num2str(isNoise),'_c106_', num2str(stim),'.mat'));
    
    %firetimes Motoneuron
    firetimes=zeros(121,20001);
    for n=1:121
        firetimes(n,:)=tmp_x{n}(2,:);
    end
    
    %Muskelfaserpotential
    mfpot=zeros(121,20001);
    for n=1:121
        mfpot(n,:)=tmp_x{n}(7,:);
    end
    
    %save firetimes to file
    save(strcat(useData,'_firetimes_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'firetimes');
    %save Muskelfaserpotential
    save(strcat(useData,'_mfpot_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'mfpot');
    %save forces
    save(strcat(useData,'_forces_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'forces');
end

for stim =0.5:0.1:1
    %load data
    load(strcat('MA_',useData,'_pPS_Noise',num2str(isNoise),'_c106_', num2str(stim),'.mat'));
    
    %firetimes
    firetimes=zeros(121,20001);
    for n=1:121
        firetimes(n,:)=tmp_x{n}(2,:);
    end
    
    %Muskelfaserpotential
    mfpot=zeros(121,20001);
    for n=1:121
        mfpot(n,:)=tmp_x{n}(7,:);
    end
    
    %save firetimes to file
    save(strcat(useData,'_firetimes_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'firetimes');
    %save Muskelfaserpotential
    save(strcat(useData,'_mfpot_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'mfpot');
    %save forces
    save(strcat(useData,'_forces_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'forces');
end