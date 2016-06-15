function [stim]=f_getStim(t,s)
    stim=interp1(s.Time,s.Data,t);
end
