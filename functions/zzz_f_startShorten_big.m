function [force] = f_startShorten_big( data, isNoise, in )

cd kermor/
KerMor.start
cd ..

switch data
    case 1
        disp(strcat('c',num2str(data),'_N_', num2str(isNoise),'_BIG'));
        [signal,force,forces]=myShorten_big(data,isNoise,in,0);
        save(strcat('MA_big_pPS_Noise',num2str(isNoise),'_c',num2str(data),'_',num2str(in*10),'.mat'));
    case 107
        disp(strcat('c',num2str(data),'_N_', num2str(isNoise),'_BIG'));
        [signal,force,forces]=myShorten_big(data,isNoise,in,0);
        save(strcat('MA_big_pPS_Noise',num2str(isNoise),'_c',num2str(data),'_',num2str(in*10),'.mat'));
    
    %{
    otherwise
        disp(data);
        [signal,force,forces]=myShorten(data,isNoise,in,0);
        save(strcat('pPS_Noise',num2str(isNoise),'_',num2str(data),'.mat'));
    %}
    end
        
end

