%preproc Shorten
for n=1:1
    clear signal;
    clear force;
    clear forces;
    [signal,force,forces]=f_myShorten(strcat('signal',num2str(n),'.mat'),1);
    save(strcat('preProcSignal',num2str(n),'NoiseON.mat'));
end

for n=1:1
    clear signal;
    clear force;
    clear forces;
    [signal,force,forces]=f_myShorten(strcat('signal',num2str(n),'.mat'),0);
    save(strcat('preProcSignal',num2str(n),'NoiseOFF.mat'));
end