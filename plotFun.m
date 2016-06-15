%% Plot a Funktion
%um Funktionen für Noise-Generator plotten

%cfg
a=9;b=9;c=9;d=9;e=1;f=1;g=1;h=1;

%Function from Noise-Scaling
fun=@(x,y)((9*((y/9)^1.24635))/(pi*(exp(log(100)*x)*3.55e-05+77.5e-4).^2)); %case0
% fun=@(x,y)((8.4437*((y/8.4437)^1.24635))/(pi*(exp(log(100)*x)*3.55e-05+77.5e-4).^2)); %case1
% fun=@(x,y)((a*y^3+b*y^2+c*y+d)/(e*x^3+f*x^2+g*x+h)); %case2

for x=0:0.1:1
    for y=0:1/120:1
        Val(round((x*10)+1),round((y*120)+1))=fun(x,y);
    end
end

%% Plot direction2
plot(0:0.1:1,Val(:,1),0:0.1:1,Val(:,11),0:0.1:1,Val(:,21),0:0.1:1,Val(:,31),...
    0:0.1:1,Val(:,41),0:0.1:1,Val(:,51),0:0.1:1,Val(:,61),0:0.1:1,Val(:,71),...
    0:0.1:1,Val(:,81),0:0.1:1,Val(:,91),0:0.1:1,Val(:,101),0:0.1:1,Val(:,111),...
    0:0.1:1,Val(:,121))
legend('MU=1','MU=11','MU=21','MU=31',...
    'MU=41','MU=51','MU=61','MU=71',...
    'MU=81','MU=91','MU=101','MU=111',...
    'MU=121')

%% Plot direction1
plot(0:120,Val(1,:),0:120,Val(2,:),0:120,Val(3,:),0:120,Val(4,:),...
    0:120,Val(5,:),0:120,Val(6,:),0:120,Val(7,:),0:120,Val(8,:),...
    0:120,Val(9,:),0:120,Val(10,:),0:120,Val(11,:))
legend('stim=0','stim=0.1','stim=0.2','stim=0.3',...
    'stim=0.4','stim=0.5','stim=0.6','stim=0.7',...
    'stim=0.8','stim=0.9','stim=1')

