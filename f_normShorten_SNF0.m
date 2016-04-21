function [ out ] = f_normShorten_SNF0( in, isNoise )

if isNoise==1
    out=in./5.4642e+04;%mit Noise
%     out=in./1.3412e+04;%mit Noise bei Fuglevand Faktor = 20;
elseif isNoise == 0
    out=in./5.1967e+04;%ohne Noise
else
    out=0;
end

end

