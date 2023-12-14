%para Ri=50
clc;clear;
Ad=tf(10^5,[1/(10*2*pi) 1])
K=1/61;
T=-K*Ad
Avfi=30;
Avf=-(Ad*Avfi/((1/K)-1))/(1-T)
wh=17e3*2*pi;%fc=17KHz
for i=1:10000
    w(i)=i*0.01*wh;%paso de 0.01*wh
    [mag,phase] = bode(Avf,w(i));
    Ev_M(i)=abs((Avfi-mag)/Avfi)*100;
    Ev_F(i)=abs((180-phase)/180)*100;
    f(i)=w(i)/(2*pi);
    
end
figure,
subplot(121),semilogx(f,Ev_M),grid minor,title('Error Vectorial Relativo de Modulo'), xlabel('f[Hz]'), ylabel('|e_r| [%]');
subplot(122),semilogx(f,Ev_F),grid minor,title('Error Vectorial Relativo de Fase'), xlabel('f[Hz]'), ylabel('|e_r| [%]');
e_r=[f;Ev_M;Ev_F]';

%otra visualizacion
figure,
semilogx(f,Ev_M,f,Ev_F), grid minor,title('Error Vectorial Relativo'),xlabel('f[Hz]'), ylabel('|e_r| [%]');
legend('Modulo','Fase')

%simulacion
H=importdata('Lab2Circ1_errorAC.txt');
ev_m=(H.data)*[0;1];
frec=(H.data)*[1;0];
figure,
semilogx(frec,ev_m,f,Ev_M), grid minor,title('Error Vectorial Relativo de Modulo'),xlabel('f[Hz]'), ylabel('|e_r| [%]'),xlim([100 1e7]);
legend('Simulacion','Calculado')

%para Ri=100k
clc;clear;
Ad=tf(10^5,[1/(10*2*pi) 1])
K=1/359.5;
T=-K*Ad
Avfi=30;
Avf=-(Ad*Avfi/((1/K)-1))/(1-T)
wh=2.78e3*2*pi;%fc=2,78KHz
for i=1:10000
    w(i)=i*0.01*wh;%paso de 0.01*wh
    [mag,phase] = bode(Avf,w(i));
    Ev_M(i)=abs((Avfi-mag)/Avfi)*100;
    Ev_F(i)=abs((180-phase)/180)*100;
    f(i)=w(i)/(2*pi);
    
end
figure,
subplot(121),semilogx(f,Ev_M),grid minor,title('Error Vectorial Relativo de Modulo'), xlabel('f[Hz]'), ylabel('|e_r| [%]');
subplot(122),semilogx(f,Ev_F),grid minor,title('Error Vectorial Relativo de Fase'), xlabel('f[Hz]'), ylabel('|e_r| [%]');
e_r=[f;Ev_M;Ev_F]';

%otra visualizacion
figure,
semilogx(f,Ev_M,f,Ev_F), grid minor,title('Error Vectorial Relativo'),xlabel('f[Hz]'), ylabel('|e_r| [%]');
legend('Modulo','Fase')

%simulacion
H=importdata('Lab2Circ1_2_errorAC.txt');
ev_m=(H.data)*[0;1];
frec=(H.data)*[1;0];
figure,
semilogx(frec,ev_m,f,Ev_M), grid minor,title('Error Vectorial Relativo de Modulo'),xlabel('f[Hz]'), ylabel('|e_r| [%]'),xlim([100 1e7]);
legend('Simulacion','Calculado')