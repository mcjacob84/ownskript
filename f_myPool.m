function [ force ] = f_myPool( forces )
%Funktion um den Pool von Shorten zu simulieren
    wid = size(forces,1);
    len = size(forces,2);
    
    P = f_getExp(100,wid);
    
    force = zeros(1,len);
    for n = 1:wid   
        force(1,:)=force(1,:)+(forces(n,:)*P(1,n));
    end
end

function [ P ] = f_getExp( const, wid )
%Beruecksichtigung Groessenordnung der Motoneuronen nach Fuglevand
    P = zeros(1,wid);
    for n = 1 : wid
        P(1,n) = exp(log(const)*(n-1)/(wid-1)); 
    end
end