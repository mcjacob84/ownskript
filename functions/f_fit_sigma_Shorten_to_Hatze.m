function [HvSerr] = f_fit_sigma_Shorten_to_Hatze(in) 
%finde die Ausgleicchsgerade mit minimaler Abweichung zwischen
%den jeweiligen Stimulationen Hatze vs Shorten
%start with: [x,fval]=fminsearch(@f_fit_sigma_Shorten_to_Hatze,[1,1])
%[x,fval]=fminbnd(@f_fit_sigma_Shorten_to_Hatze,[0,0],[1,1])

    %SON1F0
    sigma_S=[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
    sigma_H=[-0.0384,0.0381,0.1029,0.1506,0.1975,0.2470,0.2986,0.3656,0.4501,0.5539,0.6253];

    sigma_x=[0,1];
    
    sigma_opt=zeros(1,11);
    for n=1:11
        sigma_opt(n)=interp1(sigma_x,in,(n-1)/10);
    end
    
    HvSerr = sum(abs(bsxfun(@minus, sigma_H, sigma_opt)));

    %{
    plot(sigma_S,sigma_H,sigma_S,sigma_opt)
    legend('translated','opt')
    %}
    
end