function [ out ] = f_findPos( in )
%% Für Darstellung der Zitkonstanten
% aus Studienarbeit?

in=in/max(in);

for n=1:length(in)
    if in(n)>0.6
        out=n-1;
        break
    end
end

end

