function [form1, form2]=f_getFun(paramNum, param)
%function to define the different Functions used for NoiseGeneration
    

%% mit polyval kann man Polynom aufbauen

    %cfg
    
    %Standardformeln:
    quot='./(pi*(exp(log(100)*mu(1,:))*3.55e-05 + 77.5e-4).^2)';
    
    form1=strcat('mu(2,:)',quot); %mean Input mappig
    form2=strcat('(9*((mu(2,:)/9).^1.24635))',quot); %Noise Input mapping
    
    %nicht von Motoneuronengröße abhängig! (mu1?)
    %Es is der Noise des gesamten Inputs der Motoneuronen...
    %bekommen alle den selben Input
    
    switch paramNum
        case 0 %Originalformeln
            %do Nothing
        case 1 %Originale Formel mit neuer Normierung
            form2=strcat('(8.4437*((mu(2,:)/8.4437).^1.24635))',quot);
        
        case 2
            p1=[param(1),param(2),param(3),param(4)];
            form2=strcat('(polyval([',num2str(p1),'],mu(2,:)))',quot);
        case 3
            p1=[param(1),param(2),param(3),param(4)];
            form2=strcat('1./(polyval([',num2str(p1),'],mu(2,:)))',quot);
        case 4
            p1=[param(1),param(2),param(3),param(4)];
            form2=strcat('(polyval([',num2str(p1),'],mu(2,:)))',quot); 
        case 5
            p1=[param(1),param(2),param(3),param(4)];
            form2=strcat('(polyval([',num2str(p1),'],mu(2,:)))',quot); 
        case 6
            p1=[param(1),param(2),param(3),param(4)];
            form2=strcat('1./((polyval([',num2str(p1),'],mu(2,:))))',quot); 
        case 7
            p1=[param(1),param(2),param(3),param(4)];
            form2=strcat('1./((polyval([',num2str(p1),'],mu(2,:))))',quot);

        case 10%zweite Formel als einfacher Übergang
            form2=strcat(num2str(param(1)),quot);
        case 11 %Exponentialfunktion1
            form2=strcat('(',num2str(param(1)),'.*exp(',num2str(param(2)),...
                './mu(2,:)))',quot);
        case 12 %Exponentialfunktion2
            form2=strcat('(',num2str(param(1)),'.*exp(',num2str(param(2)),...
                '.*mu(2,:)))',quot);
            
        case 21 %Stadardformeln mit neuem Exponenten
            form2=strcat('(9*((mu(2,:)/9).^',num2str(param(1)),'))',quot); %Noise Input mapping
        case 22
            form2=strcat('(8.4437*((mu(2,:)/8.4437).^',num2str(param(1)),'))',quot);
            
        otherwise
            disp('Fehler: unbekannte Eingabe')
    end  
end