function [CoV] = peakFinder

CoV = zeros(47,121);

for stim = 0:0.01:0.4
    for numMU=1:121
        CoV(round((stim*100)+1), numMU)=f_peakFinder(stim,numMU);
    end
end

for stim = 0.5:0.1:1
    for numMU=1:121
        CoV(round(37+(stim*10)), numMU)=f_peakFinder(stim,numMU);
    end
end

end