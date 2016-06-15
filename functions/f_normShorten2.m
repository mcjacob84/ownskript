function [ out ] = f_normShorten2( in, numMU )
% Normierung Shorten nach individueller Anzahl an motorischen Einheiten
% aus Studienarbeit? 

    P = f_getExp(100,numMU);
    
    force = zeros(1,length(in));
    for n = 1:numMU   
        force(1,:)=force(1,:)+(in(n,:)*P(1,n));
    end
    maxF=f_getMaxF(numMU);
    out=force./maxF;
    
end