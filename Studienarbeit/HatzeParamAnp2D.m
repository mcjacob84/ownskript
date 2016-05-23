function []=HatzeParamAnp2D()
%Skript fuer die Parameteranpassung von Hatze m und nu
%Erstellt im erten Schritt die Flächenkurve

    data=7;
    isNoise=1;
    
%     isNorm=0;constv=3; constrho=4.4525; %Rockenfeller
%     isNorm=0;constv=2; constrho=9.1; %Hatze
    isNorm=0;constv=3; constrho=7.24; %Hatze
    
%     isNorm=0;constv=5.4744;constrho_C=1.8755;constm=5.3324;funName='allfree'
%     isNorm=1;constv=2.73;constrho_C=1.52;constm=5.93;funName='allfreenewNorm'    

    
%     constlCErel=1;
%     constm=10;
    
    %freie Parameter
    param1 = 1:0.1:10;
    param2 = 0:0.1:1.5;

    HvS_err = zeros(length(param1),length(param2));
    
    %Shorten
    load(strcat('Eingang/pPS_Noise',num2str(isNoise),'_c',num2str(data),'_10.mat'));
    clear force;
    forceS=f_myPool(forces);
    forceS=f_normShorten(forceS,isNoise);
    
    for n = 1:length(param1)
        for j = 1:length(param2)
            %fuer Normierung
            [~,~,q] = myHatze(6,1,0,param1(n),constrho,constv,param2(j));
            maxq=max(q);
            clear q;
            %Hatze
            [signal_Hatze,T,q,~] = myHatze(data,1,0,param1(n),constrho,constv,param2(j)); %m,rho_C,v,lCErel
            if isNorm==1
                q=q./maxq;
            end
            %error bestimmen
            HvS_err(n,j) = sum(abs(bsxfun(@minus, forceS, q)));%Normierung?           
            HvS_err(n,j)
        end
    end
    
    figure
    surf(param2,param1,HvS_err)
    xlabel('lCErel')
    ylabel('m')
    zlabel('err')
end
 
%Minimum in HvS_err finden?


% 
% function [m]=f_getm(ft,X)
%     m=interp1([0,0.3,1],[3.64,X,11.25],(ft-1)/120,'spline');
% end

%%
%trashcan

    
%     [min_err,r,c]=f_findMin(HvS_err)
%     [x,fval]=fminsearch(@f_HatzeParamAnp,[1;1])
%     [x2,fval2]=fminbnd(@f_HatzeParamAnp,[0,0],[10,10])