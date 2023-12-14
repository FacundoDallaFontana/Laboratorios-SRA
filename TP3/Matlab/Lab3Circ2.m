clc;clear;
R1=100;
R2=820;%
Ri=1000;
Rf=9000;
Rt=2.37e6;
Ct=4.8e-12;
K1=Ri/(Ri+Rf)
K2=R1/(R1+R2)
Ad=zpk([],[-10*2*pi -5.06e6*2*pi],10^5*10*2*pi*5.06e6*2*pi)
Zt=zpk([],[-1/(Ct*Rt) -2*pi*82.3e6], Rt*(1/(Ct*Rt))*2*pi*82.3e6)
%Zt=zpk([],[-1/(Ct*Rt) -2*pi*250e6 -2*pi*250e6 -2*pi*275e6 -2*pi*500e6 ], Rt*(1/(Ct*Rt))*2*pi*250e6*2*pi*250e6*2*pi*275e6*2*pi*500e6)
T2=-Zt/R2
Avfi=10;
Avf2=(1/K2)/(1-(1/T2))
Avol=Ad*Avf2
T1=-K1*Ad*Avf2
Avf1=Avol/(1-T1)


%busqueda de R1
err=1;
i=1;
h=0.1;
w=1:1000000:10^12;
%Busqueda con cruce de 1/K y Avol(compuesta)
while(err>0.01)
    R1=1*h*i^2;
    K2=R1/(R1+R2);
    T2=-Zt/R2;
    Avf2=(1/K2)/(1-(1/T2));
    Avol=Ad*Avf2;
    %
    T1=-K1*Ad*Avf2;
    Avf1=Avol/(1-T1);
    %
    [modulo]=bode(Avol,w);
    k=find(modulo<=10,1);
    wg=w(k);
    %
    [modulo]=bode(Avf1,w);
    k=find(modulo<=10*0.707,1);
    wh=w(k);
    %
    [modulo,fase]=bode(T1,w);
    k=find(fase<=65,1);
    wf=w(k);
    err=abs((wf-wg)/wf);
    i=i+1; 
end


figure,
hold on
bode(Avol)
bode(tf(10,1))
bode(T1)
legend('Compuesta Open Loop','Avfi=1/K1','Lazo T')
xlim([1 10^9])
grid minor
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear;
%Compensacion
pol=5.06e6;%polo f2 del VFA
C=0.1e-9;
R3=(1/(3.18e7*C));
R4=R3/10;
Rp=R3*R4/(R3+R4);
Comp=zpk([-1/(R3*C)],[-1/(Rp*C)],R4/(R3+R4))

R1=0.08;
R2=820;%
Ri=1000;
Rf=9000;
Rt=2.37e6;
Ct=4.8e-12;
K1=Ri/(Ri+Rf)
K2=R1/(R1+R2)
Ad=zpk([],[-10*2*pi -5.06e6*2*pi],10^5*10*2*pi*5.06e6*2*pi)
Zt=zpk([],[-1/(Ct*Rt) -2*pi*82.3e6], Rt*(1/(Ct*Rt))*2*pi*82.3e6)
%Zt=zpk([],[-1/(Ct*Rt) -2*pi*250e6 -2*pi*250e6 -2*pi*275e6 -2*pi*500e6 ], Rt*(1/(Ct*Rt))*2*pi*250e6*2*pi*250e6*2*pi*275e6*2*pi*500e6)
T2=-Zt/R2
Avfi=10;
Avf2=(1/K2)/(1-(1/T2))
Avol=Ad*Avf2*Comp %(compensacion)
%Avol=Ad*Avf2
T1=-K1*Ad*Avf2*Comp
Avf1=Avol/(1-T1)

%busqueda de R1
err=1;
i=1;
h=0.1;
w=1:1000000:10^12;
%Busqueda con cruce de 1/K y Avol(compuesta)
while(err>0.01)
    R1=1*h*i;
    K2=R1/(R1+R2);
    T2=-Zt/R2;
    Avf2=(1/K2)/(1-(1/T2));
    Avol=Ad*Avf2*Comp;
    %
    T1=-K1*Ad*Avf2*Comp;
    Avf1=Avol/(1-T1);
    %
    [modulo]=bode(Avol,w);
    k=find(modulo<=10,1);
    wg=w(k);
    %
    [modulo]=bode(Avf1,w);
    k=find(modulo<=10*0.707,1);
    wh=w(k);
    %
    [modulo,fase]=bode(T1,w);
    k=find(fase<=78.5,1);
    wf=w(k);
    err=abs((wf-wg)/wf);
    i=i+1; 
end

