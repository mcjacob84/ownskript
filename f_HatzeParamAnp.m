function [HvS_err] = f_HatzeParamAnp (in)
%Funktion um HvS_err min zu finden ueber Funktion
%fminsearch,fminbnd
%siehe Skript: HatzeParamAnpSigma1.mat
%Eingabe: f_HatzeParamAnp([m;rho_C;v])
%Aufruf1: 
%[x,fval]=fminsearch(@f_HatzeParamAnp,[1;1])
%Aufruf2:
%[x,fval]=fminbnd(@f_HatzeParamAnp,[1.5;4;3;0.4;2.2],[4;11;11;1.6;3.6]);%[v,rho,m,lCErel,lrho]

    %cfg
    data=7;
    isNoise=1;
    asc=0;
    desc=0;
    variante=2;

% % % % % % %    
if variante==1
    isNorm=0;constv=3;constrho=4.4525; %Rockenfeller
%     isNorm=0;constv=2; constrho=9.1; %Hatze
%     isNorm=0;constv=3; constrho=7.24; %Hatze
    
    if length(in) < 3
        lrho=2.9;
    else
        lrho=in(3);
    end
    if length(in)< 2
        lCErel=1;
    else
        lCErel=in(2);
    end
    constm=in(1);
% % % % % % %
elseif variante==2
    isNorm=0;constv=in(1);constrho=in(2);constm=in(3);
    lCErel=1;lrho=2.9;  
% % % % % % % 
end

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
    
    if asc==1
        forceS=forceS(1:911);
        q=q(1:911);
    end
    if desc==1
        forceS=forceS(911:end);
        q=q(911:end);
    end 
    HvS_err = sum(abs(bsxfun(@minus, forceS, q)));%Normierung?
end