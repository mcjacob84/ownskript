%%
%Anzahl an Fasern die Kraft erzeugen über sigma

%cfg
isNoise=0; %standardmaessig 0, um genau zu erkennen, welche MU aus und welche an ist.

numMU=zeros(1,47)+121;

for n = 1:41
    tmp_pointer=1;
    load(strcat('SO_forces_Stim',num2str((n-1)/100),'_Noise',num2str(isNoise),'.mat'),'forces');
    for k=1:121
        if forces(k,:)==0 & tmp_pointer==1
            numMU(n)=k;
            tmp_pointer=0;
        end
    end
end
    
for n = 0.5 : 0.1 : 1
    tmp_pointer=1;
    load(strcat('SO_forces_Stim',num2str(n),'_Noise',num2str(isNoise),'.mat'),'forces');
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