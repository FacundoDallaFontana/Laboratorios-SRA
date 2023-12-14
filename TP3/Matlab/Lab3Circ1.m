%% SIMBOLICOS
clc;clear;
syms K1 K2 w1 w2 Ado s
Ad=Ado/(((s/w1)+1)*((s/w2)+1))
T2=-K2*Ad
Avf2=Ad/(1-T2)
Avol=Ad*Avf2
T1=-K1*Ad*Avf2
Avf1=Avol/(1-T1)
%% ALGORITMO
clc;clear;

R1=1000;
R2=1;%
Ri=1000;
Rf=9000;
Ad=zpk([],[-10*2*pi -5.06e6*2*pi],10^5*10*2*pi*5.06e6*2*pi)
%Ad=tf(10^5,[1/(10*2*pi) 1])
K2=R1/(R1+R2)
K1=Ri/(Ri+Rf)

T2=-K2*Ad
Avfi=10;
Avf2=Ad/(1-T2)
Avol=Ad*Avf2
T1=-K1*Ad*Avf2
Avf1=Avol/(1-T1)




%busqueda de R2
err=1;
i=1;
h=0.1;
w=1:10000:10^8;
%Busqueda con cruce de 1/K y Avol(compuesta)
while(err>0.01)
    R2(1)=1*h*i^2;
    K2=R1/(R1+R2(1));
    T2=-K2*Ad;
    Avf2=Ad/(1-T2);
    Avol=Ad*Avf2;
    T1=-K1*Ad*Avf2;
    Avf1=Avol/(1-T1);
    %
    [modulo]=bode(Avol,w);
    k=find(modulo<=10,1);
    wg(1)=w(k);
    %
    [modulo]=bode(Avf1,w);
    k=find(modulo<=10*0.707,1);
    wh(1)=w(k);
    %
    [modulo,fase]=bode(T1,w);
    k=find(fase<=65,1);
    wf(1)=w(k);
    err=abs((wf(1)-wg(1))/wf(1));
    i=i+1; 
end


err=1;
i=1;
h=0.01;
w=1:10000:10^8;

%Busqueda con caida 3dB AvfTotal
while(err>0.01)
    R2(2)=1*h*i^2;
    K2=R1/(R1+R2(2));
    T2=-K2*Ad;
    Avf2=Ad/(1-T2);
    Avol=Ad*Avf2;
    T1=-K1*Ad*Avf2;
    Avf1=Avol/(1-T1);
    %
    [modulo]=bode(Avf1,w);
    k=find(modulo<=10*0.707,1);
    wh(2)=w(k);
    %
    [modulo]=bode(Avol,w);
    k=find(modulo<=10,1);
    wg(2)=w(k);
    %
    [modulo,fase]=bode(T1,w);
    k=find(fase<=65,1);
    wf(2)=w(k);
    err=abs((wf(2)-wh(2))/wf(2));
    i=i+1; 
end

err=1;
i=1;
h=0.1;
w=1:10000:10^8;
%Busqueda con caida wg=0.644*wh (max planicidad de modulo)
while(err>0.01)
    R2(3)=1*h*i^2;
    K2=R1/(R1+R2(3));
    T2=-K2*Ad;
    Avf2=Ad/(1-T2);
    Avol=Ad*Avf2;
    T1=-K1*Ad*Avf2;
    Avf1=Avol/(1-T1);
    %
    [modulo]=bode(Avf1,w);
    k=find(modulo<=10*0.707,1);
    wh(3)=w(k);
    %
    [modulo]=bode(Avol,w);
    k=find(modulo<=10,1);
    wg(3)=w(k);
    %
    [modulo,fase]=bode(T1,w);
    k=find(fase<=65,1);
    wf(3)=w(k);
    err=abs((wg(3)-0.644*wh(3))/wg(3));
    i=i+1; 
end


%R_2=(R2(1)+R2(2))/2
R_2=R2(1);%la queramos usar
K2=R1/(R1+R_2);
T2=-K2*Ad;
Avf2=Ad/(1-T2);
Avol=Ad*Avf2;
T1=-K1*Ad*Avf2;
Avf1=Avol/(1-T1);
    
%Caso1

figure,
hold on
bode(Avol)
bode(tf(10,1))
bode(T1)
legend('Compuesta Open Loop','Avfi=1/K1','Lazo T')
xlim([1 10^9])
grid minor
hold off

%Caso 2
figure,
hold on
bode(Avf1)
bode(T1)
legend('Avf','Lazo T')
xlim([1 10^9])
grid minor
hold off

%Caso 3
figure,
hold on
bode(Avol)
bode(tf(10,1))
bode(Avf1)
bode(T1)
legend('Compuesta Open Loop','Avfi=1/K1','Avf','Lazo T')
xlim([1 10^9])
grid minor
hold off

hold on
bode(Avol)
bode(tf(10,1))
bode(Ad)
%bode(T1)
xlim([1 10^9])
grid minor
hold off


step(Avf1)