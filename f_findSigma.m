function [ HvSerr ] = f_findSigma( sigma )
%method to translate sigma from Hatze to Shorten
%finding corresponding sigma of Shorten zu sigma of Hatze
%start with: [sigma,fval]=fminsearch(@f_findSigma,1)  
    
    %cfg
    stim = 0.39;
    isNoise = 1;
    
    %load Shorten 
    %Einzelheiten anpassen (SO, SN)
    load(strcat('SO_forces_Stim',num2str(stim),'_Noise',num2str(isNoise),'.mat'));
    force=f_normShorten_SOF0(f_myPool(forces),isNoise);
    
    %load Hatze
    [~,T,q,~] = myHatze(106,sigma,0,11,4.4525,3);
   
    %Gebiet eingrenzen
    force=force(15001:20001);
    q=q(15001:20001);
    
    %get error
    HvSerr = sum(abs(bsxfun(@minus, force, q)));

end