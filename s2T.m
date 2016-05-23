%Demonstrationen für Besprechung
%%

%Lese Zeilenweise (über Stimulation) die ganzen Zahlen aus und bilde
%m/s/CoV

%init
cfg.dataSet={'ft','mfpot'};
cfg.m=zeros(47,length(cfg.dataSet));
cfg.s=zeros(47,length(cfg.dataSet));
cfg.PointerCoV=ones(1,2);

CoV1=zeros(47,length(cfg.dataSet)+1);

for l=1:length(cfg.dataSet)
    load(strcat('CoV_',cfg.dataSet{l},'_SON1F0_1.mat'));
    CoV=ans;
    
    %copy cells
    for n = 1 : length(CoV(:,1))
        vector=zeros(1,1);
        cfg.pointer=1;
        for m = 1 : 121
            cfg.eintrag=CoV(n,m);
            if isnan(cfg.eintrag)
                %do nothing
            else
                vector(cfg.pointer)=cfg.eintrag;
                cfg.pointer=cfg.pointer+1;
            end
        end
        if length(vector)>1
            cfg.m(n,l)=mean(vector);
            cfg.s(n,l)=std(vector);
            CoV1(cfg.PointerCoV(l),l)=cfg.s(n,l)/cfg.m(n,l)*100;
        end
        cfg.PointerCoV(l)=cfg.PointerCoV(l)+1;
    end
end

%non variable length at this moment...
CoV1(:,length(cfg.dataSet)+1)=CoV1(:,1)-CoV1(:,2);

for pointer=0:0.01:0.4
    CoV1(round((pointer*100)+1),4)=pointer;
end

load('CoV_mfpot_SON1F0_1.mat');
mfpot=ans;
load('CoV_ft_SON1F0_1.mat');
firetimes=ans;
diff=mfpot-firetimes;

%Interessant:
%diff - Abweichungen der CoVs vom IsI zwischen MU und MF
%CoV1 - schlechte Darstellung (CoV vom CoV)

%%
%mfpot und ft peakFinder untereinander darstellen
%cfg
cfg.stim=0.25;
cfg.fibre=120;

figure;
plot_Motoneuron = subplot(2,1,1);
%title('Motoneuron')
f_peakFinder_FT(cfg.stim,cfg.fibre,1);

plot_Muskelfaser = subplot(2,1,2);
%title('Muskelfaser')
f_peakFinder_mfpot(cfg.stim,cfg.fibre,1);

linkaxes([plot_Motoneuron, plot_Muskelfaser],'xy')

%%
%CoV forces
isNoise=1;
CoV1=zeros(2,41);
tmp.counter=1;
for stim=0:0.01:0.4
    %load Shorten
    load(strcat('SO_forces_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'),'forces');
    newForces=zeros(121,4001);
    newForces(:,:)=forces(:,10001:14001);
    
    for fibretype = 1 : 121
        F(1,fibretype)=min(newForces(fibretype,:));
        F(2,fibretype)=max(newForces(fibretype,:)); 
    end
    F2(tmp.counter,:)=F(1,:);
    tmp.counter=tmp.counter+1;
    F2(tmp.counter,:)=F(2,:);
    tmp.counter=tmp.counter+1;
    
    m=mean(F');
    s=std(F');
    
    CoV1(1,round((stim*100)+1))=s(1)/m(1)*100;
    CoV1(2,round((stim*100)+1))=s(2)/m(2)*100;
    
end

m2=mean(F2);
s2=std(F2);

for n = 1:121
    CoV2(1,n)=s2(n)/m2(n)*100;
end

%CoV1 forces über die Stimulationen
%immer CoV des Min über alle MUs und des Max ueber alle MUs
%{
plot(CoV1')
legend('min','max')
%}

%CoV2 
%Schwankungen der Min und Max in der jeweiligen Muskelfaser ueber alle
%sigma hinweg
%{
plot(CoV2)
%}