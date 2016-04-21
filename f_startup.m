function [] = f_startup()
%{
Funktion fuer Startup
%}

mode=1;

if mode==1
        addpath('C://Users/Marc/kermor/kermor');
        addpath('C://Users/Marc/Google Drive/Masterarbeit/Matlab');
        KerMor.start    
elseif mode==2
        addpath('C://Users/mcjacob/Google Drive/Studienarbeit/Modelle/Skripte');
        addpath('C://Users/mcjacob/Google Drive/Studienarbeit/Modelle/Skripte/functions');
        addpath('C://Users/mcjacob/Google Drive/Studienarbeit/Modelle/Skripte/V2');
        addpath('C://Users/mcjacob/Google Drive/Studienarbeit/Modelle/results');
        cd('C:\Users\mcjacob\Google Drive\Studienarbeit\Modelle\results')
end


end

%{
cd ('C:\Users\Marc\Dropbox\aktuelles\Studienarbeit\Modelle\Skripte')
cd('C:\Users\Marc\Dropbox\aktuelles\Studienarbeit\Modelle\preproc_Shorten')
%}