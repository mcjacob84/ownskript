%Test um Struktur von KerMor zu begreifen.
%Einfach mal eine Muskelfaser durchlaufen lassen.

%cfg
cfg.stim=0.1;%[0:1]
cfg.fasertyp=1;%[0:120]

%changed by MJ giving free Parameter 'param' to Shorten.m
%Noise scaling
m = models.motorunit.Shorten(1.24635,'SarcoVersion', 1);
m.System.f.LinkSarcoMoto=1;

mu = [0.0083*cfg.fasertyp;8.4437*cfg.stim]

[t,y]=m.simulate(mu);
m.plot(t,y) 