function [ P ] = f_getExp( const, wid )
%Beruecksichtigung Groessenordnung der Motoneuronen nach Fuglevand
    P = zeros(1,wid);
    for n = 1 : wid
        P(1,n) = exp(log(const)*(n-1)/(wid-1)); 
    end
end

