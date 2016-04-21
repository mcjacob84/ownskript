function [signal,T,q,force]=myHatze(Data,maxStim,minStim,m,rhoC,v,lCErel,lrho,qH0)

if nargin < 9
    qH0 = 0;
    if nargin < 8
        lrho=2.9;
        if nargin < 7
            lCErel=1;
        end
    end
end

    signal=f_getSignal(Data,minStim);
    tmp.stim=@(t)(f_getStim(t,signal))*maxStim;
    tmp.const=f_initConst(v,m,rhoC,lCErel,lrho,qH0);
    
    options=odeset('RelTol',1e-6,'AbsTol',1e-6);
    [T,Y]=ode15s(@(t,g)(f_dgdt(t,g,tmp)),[0 signal.totalTime],tmp.const(1),options);
    
    q=(tmp.const(6)+(tmp.const(10).*Y).^tmp.const(3))./(1+(tmp.const(10).*Y).^tmp.const(3));
    q=interp1(T,q,0:0.001:signal.totalTime);
    
    %zusätzlich Kraftberechnung nach Häufle et al.
    %optimale Sakomerlänge bei 2.5µm (Enoka 2003)
    if lCErel>=1
        force=q.*exp(-abs((lCErel-1)/0.35)^1.5);%descending
    else
        force=q.*exp(-abs((lCErel-1)/0.35)^3);%ascending
    end    
    
    T=0:0.001:signal.totalTime;
end

function dg=f_dgdt(t,g,tmp)
    dg=tmp.const(5)*(tmp.stim(t)-g);
end

function [const]=f_initConst(v,m,rhoC,lCErel,lrho,qH0)
    const=zeros(1,10);
    const(1)=qH0; %q_H0 (Anfangsbedingung)
    const(2)=2.2; %l_CE -> variabel
    const(3)=v; %v
    const(4)=rhoC; %rho_C variabel
    const(5)=m; %m variabel
    const(6)=0.005; %q_0 -> const?
    const(7)=lrho; %l_p -> const?
    const(8)=2.2; %l_CEopt -> const!
    const(9)=lCErel; %l_CErel
    const(10)=const(4)*(const(7)-1)/((const(7)/const(9))-1); %rho
end

function [stim]=f_getStim(t,s)
%Gibt den Modellen die jeweilige Stimulation zum Zitpunkt t zurueck
    stim=interp1(s.Time,s.Data,t);
end

function [m]=f_getm(ft)
   m=interp1([0,0.3,1],[3.64,X,11.25],(ft-1)/120,'spline');
end