function [edges, diffedges] = f_findPeak( dataSet, rborder, refTime)
% Funktion von Thomas zur Peak-Detektion von mfpot und firetimes
% difference in rborder


    signaltemp=dataSet(1:end-1);
    signaltempshifted=dataSet(2:end);

    edges=find(signaltemp>rborder & signaltempshifted<rborder); % falling edges
    %Doppeldetektionen vermeiden
    for n = 2 : length(edges)
        %Doppeldetektionen <refTime aus edges löschen
        if edges(n-1)>=edges(n)-refTime
            edges(n-1)=[];
        end
        if n >= length(edges)
            break;
        end
    end
    
    %Differenz der edges
    diffedges = zeros(1,length(edges)-1);
    for n=1:length(edges)-1
        diffedges(n)=edges(n+1)-edges(n);
    end

end

