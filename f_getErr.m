function [HvS_err]=f_getErr(m,nu,rho)
%Fehler über gesamten Bereich ausgeben

    %cfg
    data=7;
    isNoise=1;
    
    isNorm=0;constv=nu;constrho=rho; %Rockenfeller
    
    lrho=2.9;
    lCErel=1;
    constm=m;


    %fuer Normierung
    [~,~,q] = myHatze(6,1,0,constm,constrho,constv,lCErel,lrho);
    maxq=max(q);
    clear q;
    
    %Shorten
    load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(data),'_10.mat'));
    forceS=f_myPool(forces);
    forceS=f_normShorten(forceS,isNoise);
    
    %Hatze
    [~,~,q] = myHatze(data,1,0,constm,constrho,constv,lCErel,lrho);
    if isNorm==1
        q=q./maxq;
    end
    
    forceS=forceS(1:2001);
    q=q(1:2001);
    
    HvS_err = sum(abs(bsxfun(@minus, forceS, q)));%Normierung?
end