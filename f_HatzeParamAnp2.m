function [ HvS_err ] = f_HatzeParamAnp2( X )
%Hatzepool???
%Version2: optimale m Interpolation finden
%Funktion um HvS_err min zu finden ueber Funktion
%fminsearch,fminbnd
%siehe Skript: HatzeParamAnpSigma1.mat
%Eingabe: f_HatzeParamAnp([m;rho_C;v])
%Aufruf: [x,fval]=fminsearch(@f_HatzeParamAnp2,[1])

    
%%
%cfg
data=7;
isNoise=1;
    
constv=3;
constrho=3.25;
% constrho=7.24;
    
%%
    
    %Shorten
    load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(data),'_10.mat'));
    forceS=f_myPool(forces);
    forceS=f_normShorten(forceS);
    %Hatzepool?
    for ft=1:121
    [~,T,q(ft,:)]=myHatze(data,1,0,f_getm(ft,X),constrho,constv);
    end
    forceH=sum(q)/121;
    HvS_err = sum(abs(bsxfun(@minus, forceS, forceH)));
end

function [m]=f_getm(ft,X)
    m=interp1([0,0.8,1],[3.64,X,11.25],(ft-1)/120,'spline');
end

