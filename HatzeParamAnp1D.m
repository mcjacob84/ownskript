
%HATZEPRAMANP1D Summary of this function goes here
%   Detailed explanation goes here

%Skript fuer die Parameteranpassung von Hatze m und nu
%Erstellt im erten Schritt die Flächenkurve

    data=7;
    isNoise=1;
    
%     isNorm=0;constv=3; constrho=4.4525; %Rockenfeller
%     isNorm=0;constv=2; constrho=9.1; %HatzeA
    isNorm=0;constv=3; constrho=7.24; %HatzeB
    
%     isNorm=0;constv=5.4744;constrho_C=1.8755;constm=5.3324;funName='allfree'
%     isNorm=1;constv=2.73;constrho_C=1.52;constm=5.93;funName='allfreenewNorm'    

    
%     constlCErel=1;
%     constm=10;
    
    %freie Parameter
    param1 = 1:0.1:20;

    HvS_err = zeros(length(param1));
    
    %Shorten
    load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(data),'_10.mat'));
    clear force;
    forceS=f_myPool(forces);
    forceS=f_normShorten(forceS,isNoise);
    
    for n = 1:length(param1)
            %fuer Normierung
            [~,~,q] = myHatze(6,1,0,param1(n),constrho,constv);
            maxq=max(q);
            clear q;
            %Hatze
            [signal_Hatze,T,q,~] = myHatze(data,1,0,param1(n),constrho,constv); %m,rho_C,v,lCErel
            if isNorm==1
                q=q./maxq;
            end
            %error bestimmen
            HvS_err(n) = sum(abs(bsxfun(@minus, forceS, q)));%Normierung?           
    end
    
    figure
    plot(param1,HvS_err(:,1),'LineWidth',1.7)
    xlabel('m','Fontsize',19,'FontAngle','italic')
    ylabel('err','Fontsize',19)
    set(gca,'Fontsize',19)
    
    clc
    clear all


