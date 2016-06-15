function [x,fval] = findFormulaSO()

    cd kermor/
    KerMor.start
    cd ..
    
    %Versionsauswahl!!!
    global startWertforFormulaSearch2016;
    startWertforFormulaSearch2016=[-10 10]
    [x,fval]=fminsearch(@f_findFormulaSO,startWertforFormulaSearch2016); %Startwerte unten eintragen!!!
    
%     f_findFormulaSO_v2();

end

%% Version 2 siehe unten!

function [CoV2] = f_findFormulaSO(parameter)
% Skript to find optimal Formula for NG
%start with: [x,fval]=fminsearch(@findFormulaSO,[100,100,100,100,100,100,100,100])

%Check: stimmen die Dimensionen der Matrizen?

    global startWertforFormulaSearch2016;
    %cfg
    paramNum=11;
    in=1;
    data=106;
    isNoise=1;
    disp(strcat('SO_findFormulaSO_c', num2str(data), '_N_', num2str(isNoise), '_ParamNum', num2str(paramNum)));
   
    [fun1, fun2] = f_getFun(paramNum, parameter);
  
    [signal, force, forces, tmp_t, y, tmp_sec, tmp_x]=f_startShortenSO(data, isNoise, in, 0, fun1, fun2);
    
    %Muskelfaserpotential
    for n = 1 : size(tmp_x,2)
        mfpot(n,:)=tmp_x{n}(7,10001:14001);
    end
    
    %CoV berechnen (erstmal Motoneuron, da stabiler)
    for pos=1:size(mfpot,1)
        edges=f_findPeak(mfpot(pos,:),-50,5);
        diffedges = zeros(1,length(edges)-1);
        for n=1:length(edges)-1
            diffedges(n)=edges(n+1)-edges(n);
        end
           
        s(pos)=std(diffedges);
        m(pos)=mean(diffedges);
        CoV(pos)=s(pos)/m(pos)*100;
    end
    
    CoV2=mean(CoV);
    CoV2=abs(CoV2-13);

    save(strcat('SO2_findFormulaSO_Noise',num2str(isNoise),'_c',num2str(data),'_stim',num2str(in),'_ParamNum',num2str(paramNum),'_SW_',num2str(startWertforFormulaSearch2016),'.mat'),'-v7.3');
end

%%

function [CoV2] = f_findFormulaSO_v2()
%Version2
%Konstante Werte für form2 übergeben und schauen, wie sich CoV verhält...
    
    
        %cfg
        paramNum=10;
        in=1;
        data=106;
        isNoise=1;
        disp(strcat('SO_findFormulaSO_konstForm2_c', num2str(data), '_N_', num2str(isNoise), '_ParamNum', num2str(paramNum)));
        CoV=zeros(3,20001)+1000;
        
        for param=-10000:10000
            param
            try
                [fun1, fun2] = f_getFun(paramNum, param);
  
                [signal, force, forces, tmp_t, y, tmp_sec, tmp_x]=f_startShortenSO(data, isNoise, in, 0, fun1, fun2);
    
                %Muskelfaserpotential
                for n = 1 : size(tmp_x,2)
                    mfpot(n,:)=tmp_x{n}(7,10001:14001);
                end
    
                %CoV berechnen (erstmal Motoneuron, da stabiler)
                for pos=1:size(mfpot,1)
                    edges=f_findPeak(mfpot(pos,:),-50,5);
                    diffedges = zeros(1,length(edges)-1);
                    for n=1:length(edges)-1
                        diffedges(n)=edges(n+1)-edges(n);
                    end
           
                    s((param+10001),pos)=std(diffedges);
                    m((param+10001),pos)=mean(diffedges);
                    CoV((param+10001),pos)=s((param+10001),pos)./m((param+10001),pos).*100;
                end
            
                CoV2((param+10001))=mean(CoV((param+10001),:));
            catch
                disp('---> An error occurred. Execution will continue.');
            end  
        end
    
        CoV2=abs(CoV2-13);

    save(strcat('SO2_findFormulaSO_konstForm2_Noise',num2str(isNoise),'_c',num2str(data),'_stim',num2str(in),'_ParamNum',num2str(paramNum),'.mat'),'-v7.3');

end