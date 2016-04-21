function [ out ] = f_normShorten2( in, numMU )
    
    P = f_getExp(100,numMU);
    
    force = zeros(1,length(in));
    for n = 1:numMU   
        force(1,:)=force(1,:)+(in(n,:)*P(1,n));
    end
    maxF=f_getMaxF(numMU);
    out=force./maxF;
    
end

function [ P ] = f_getExp( const,numMU )
%Beruecksichtigung Groessenordnung der Motoneuronen nach Fuglevand
P = zeros(1,numMU);
for n = 1 : numMU
    P(1,n) = exp(log(const)*(n-1)/(numMU-1)); 
end
end

function [ maxF ] = f_getMaxF( MU )
    switch MU
        case 2
            maxF=1.6137e+03;
        case 3
            maxF=1.7710e+03;
        case 4
            maxF=2.0697e+03;
        case 5
            maxF=2.3648e+03;
        case 7
            maxF=2.9719e+03;
        case 9 
            maxF=3.6949e+03;
        case 11
            maxF=4.3803e+03;
        case 13
            maxF=5.0441e+03;
        case 16 
            maxF=6.2080e+03;
        case 21
            maxF=7.9186e+03;
        case 25
            maxF=9.1776e+03;
        case 31
            maxF=1.1743e+04;
        case 41
            maxF=1.5061e+04;
        case 61
            maxF=2.2769e+04;
        case 121
            maxF=4.4288e+04;
    end        
end