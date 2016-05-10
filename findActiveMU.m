%Anzahl an Fasern die Kraft erzeugen über sigma
%+force_recruitedMU_relationship!

%cfg
useData='SO'; %use data von sarcoNeumann or sarcoOriginal
    %bis jetzt glaub nur für SO funktionsfähig (peakfinder...)
isNoise=0; % hier: standard auf 0 (welche MU feuern gesucht)

numMU=zeros(1,47)+121;
max_force=zeros(1,47);

for n = 1:41
    tmp_pointer=1;
    load(strcat(useData,'_forces_Stim',num2str((n-1)/100),'_Noise',num2str(isNoise),'.mat'),'forces');
    for k=1:121
        if forces(k,:)==0 & tmp_pointer==1
            numMU(n)=k;
            tmp_pointer=0;
        end
    end
end
    
for n = 0.5 : 0.1 : 1
    tmp_pointer=1;
    load(strcat(useData,'_forces_Stim',num2str(n),'_Noise',num2str(isNoise),'.mat'),'forces');
    for k=1:121
        if forces(k,:)==0 & tmp_pointer==1
            numMU(37+(n*10))=k;
            tmp_pointer=0;
        end
    end
end

%zugehörigen Vektor für sigma erstellen 
sigma=zeros(1,46);
for n=1:41
    sigma(n)=(n-1)/100;
end
for n=5:10
    sigma(37+n)=n/10;
end

%plot(sigma,numMU)

%%
%find max force

%cfg
isNoise=1; %hier: standard auf 1 (maxforce gesucht)

for n = 1:41
    load(strcat(useData,'_forces_Stim',num2str((n-1)/100),'_Noise',num2str(isNoise),'.mat'),'forces');
    if strcmp(useData,'SO')
        force=f_normShorten_SOF0(f_myPool(forces),isNoise);
    esleif strcmp(useData,'SN')
        force=f_normShorten_SNF0(f_myPool(forces),isNoise);
    else
        %Datensatz nicht erkannt
    end
    max_force(n)=max(force);
end 

for n = 0.5 : 0.1 : 1
    load(strcat('SO_forces_Stim',num2str(n),'_Noise',num2str(isNoise),'.mat'),'forces');
     if strcmp(useData,'SO')
        force=f_normShorten_SOF0(f_myPool(forces),isNoise);
    esleif strcmp(useData,'SN')
        force=f_normShorten_SNF0(f_myPool(forces),isNoise);
    else
        %Datensatz nicht erkannt
    end
    max_force(37+(n*10))=max(force);
end

plot(max_force,numMU)
xlabel('norm. force')
ylabel('recruited MU')