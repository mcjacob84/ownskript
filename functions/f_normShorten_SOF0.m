function [ out ] = f_normShorten_SOF0( in, isNoise )
%Norm Shorten to maxF Fatique=0

    if isNoise==1
        out=in./1.0469e+05;%mit Noise
    %     out=in./1.3412e+04;%mit Noise bei Fuglevand Faktor = 20;
    elseif isNoise == 0
        out=in./8.6359e+04;%ohne Noise
    else
        out=0;
    end

end

