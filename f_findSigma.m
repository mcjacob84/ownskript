function [ HvSerr ] = f_findSigma( sigma )
%method to translate sigma from Hatze to Shorten
%start with: [sigma,fval]=fminsearch(@f_findSigma,1);    
    
    %cfg
    stim = 7;
    isNoise = 1;
    
    %load Shorten
    load(strcat('C:/Users/mcjacob/Google Drive/Masterarbeit/Matlab/res_v01/MA_SN_pPS_Noise', ...
        num2str(isNoise),'_c106_',num2str(stim),'.mat'),'forces');
    force=f_normShorten_SNF0(f_myPool(forces),isNoise);
    
    %load Hatze
    [~,T,q,~] = myHatze(106,sigma,0,11,4.4525,3);
   
    %Gebiet eingrenzen
    force=force(15001:20001);
    q=q(15001:20001);
    
    %get error
    HvSerr = sum(abs(bsxfun(@minus, force, q)));

end