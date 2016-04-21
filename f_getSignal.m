function [signal]=f_getSignal(p,minStim)
%liefert Standardsignale für die Modelle
%myShorten und myHatze

%cfg
% maxStim = 0.1;

    switch p
        case 1 %non-balistic
            signal.Time=[0,0.5,3.5,3.5+1e-12,6.5];
            signal.Data=[0,0,1,1,0];
            signal.totalTime=[6.5];
        
        %Studienarbeit
        case 101
            signal.Time=[0,0.7,0.7+1e-12,2];
            signal.Data=[1,1,0,0];
            signal.totalTime=[2];
        case 102
            signal.Time=[0,0.7,0.7+1e-12,2];
            signal.Data=[1,1,minStim,minStim];
            signal.totalTime=[2];
        case 103
            signal.Time=[0,2,2+1e-12,4];
            signal.Data=[1,1,0,0];
            signal.totalTime=[4];
        case 104
            signal.Time=[0,2,2+1e-12,4];
            signal.Data=[1,1,minStim,minStim];
            signal.totalTime=[4];
        case 105 %0.2 sekunden Maxstim
            signal.Time=[0,0.2,0.2+1e-12,0.5];
            signal.Data=[1,1,0,0];
            signal.totalTime=[0.5];
        case 106 %Normierung Hatze
            signal.Time=[0,1,1+1e-12,20];
            signal.Data=[0,0,1,1];
            signal.totalTime=[20];
        case 107 %erreicht maxStim mit Noise
            signal.Time=[0,0.911,0.911+1e-12,4];
            signal.Data=[1,1,0,0];
            signal.totalTime=[4];
        case 108 %erreicht maxStim mit Noise
            signal.Time=[0,0.911,0.911+1e-12,4];
            signal.Data=[1,1,minStim,minStim];
            signal.totalTime=[4];
        case 111
            signal.Time=[0,2];
            signal.Data=[0,0];
            signal.totalTime=[2];
        case 112
            signal.Time=[0,0.150];
            signal.Data=[1,1];
            signal.totalTime=[0.150];
        
        otherwise %load signal
            load(p);
    end
end