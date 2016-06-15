function [signal, force, forces, tmp_t, y, tmp_sec, tmp_x] = MvMvG( version )
% Skript to generate ShortenOriginal Data

cd kermor/
KerMor.start
cd ..

%cfg
project='MouseVsMenVsGiant';
data=106;
isNoise=1;
paramNum=0;
parameter=0;
in=1;

disp(strcat('SO_',project,num2str(version),'_c',num2str(data),'_N', num2str(isNoise),'_ParamNum',num2str(paramNum)));
[fun1,fun2]=f_getFun(paramNum,parameter);
[signal,force,forces,tmp_t,y,tmp_sec,tmp_x]=f_startShortenSO(data,isNoise,in,0,fun1, fun2);
save(strcat(project,num2str(version),'_Noise',num2str(isNoise),'_c',num2str(data),'_stim',num2str(in),'_ParamNum',num2str(paramNum),'.mat'));
end