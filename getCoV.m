isNoise=1;
for stim=0:0.1:1
    load(strcat('c:/Users/Marc/Desktop/res_MA/MA_SO_pPS_Noise',num2str(isNoise),'_c106_',num2str(stim),'.mat'),'forces');
    
    %load Shorten
    force=f_myPool(forces);
    force=f_normShorten_SOF0(force, isNoise);
    force=force(15001:20001);
    
    s=std(force);
    m=mean(force);
    
    CoV=s/m*100;
    
    strcat('Stim=',num2str(stim),'; CoV=',num2str(CoV))
end
    
    
    