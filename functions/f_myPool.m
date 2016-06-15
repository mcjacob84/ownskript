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