%% Test um Struktur von KerMor zu begreifen.
%Einfach mal eine Muskelfaser durchlaufen lassen.

%cfg
cfg.stim=1;%[0:1]
% cfg.fasertyp=60;
cfg.doPlot=0;

CoV=zeros(3,100);

%formula is the NG-Formula giving over to Shorten (1x2 Vektor)
% for val=1000:1000:100000
    [form1,form2]=f_getFun(0,0);

    %changed by MJ giving free Parameter 'param' to Shorten.m
    %Noise scaling
    m = models.motorunit.Shorten(form1, form2,'SarcoVersion', 1);
    m.System.f.LinkSarcoMoto=1;
    
    for fasertyp=120:120
        mu = [1/120*fasertyp;8.4437*cfg.stim]; 
        %mu_1=Fasertyp
        %mu_2=stim

        [t,y]=m.simulate(mu);

        [edges,diffedges]=f_findPeak(y(1,:),-50,5);

        if cfg.doPlot==1
            plot(t,y(1,:),'r')
            hold on
            for n = 1 : length(edges)
                line([edges(n) edges(n)]./10, [0 10])
            end
        end

        mD=mean(diffedges);
        sD=std(diffedges);
        CoV((fasertyp/60)+1,1)=sD/mD*100;
    end
% end