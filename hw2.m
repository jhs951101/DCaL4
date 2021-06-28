clear all;
close all;

echo on
df=0.3;
ts=1/1500;
fs=1/ts;
fc=250;
T1=-0.1; T2=0.1;
t=[T1:ts:T2];
N=length(t);

tau=0.1;
x=triangle(tau, T1, T2, fs);
xc=cos(2*pi*fc.*t);
xm=x.*xc;
[X,x,df1]=fft_mod(x,ts,df);

X=X/fs;
[Xm,xm,df1]=fft_mod(xm,ts,df);
Xm=Xm/fs;
[XC,xc,df1]=fft_mod(xc,ts,df);
clf
f=[0:df1:df1*(length(xm)-1)]-fs/2;
subplot(2,1,1)
plot(t,x(1:length(t)))
title('Message signal')
subplot(2,1,2)
plot(t,xm(1:length(t)))
xlabel('Time')
title('Modulated signal')
pause
subplot(2,1,1)
plot(f,abs(fftshift(X)))
title('Spectrum of the message signal')
subplot(2,1,2)
plot(f,abs(fftshift(Xm)))
title('Spectrum of the modulated signal')
xlabel('Frequency')

r=xm;
[R,r,df1]=fft_mod(r,ts,df);
R=R/fs; % scaling

xc2 = cos(2*pi*fc.*t + pi);  % xc2: 복조에 사용되는 정현파 신호 
                             % pi/2 (90도) 또는 pi (180도) 를 더해줌으로써 위상 차이를 발생시킬 수 있음 
[XC2,xc2,df1]=fft_mod(xc2,ts,df);

y=r.*xc2;
[Y,y,df1]=fft_mod(y,ts,df);
Y=Y/fs;
f_cutoff=150;
n_cutoff=floor(f_cutoff/df1);
H=zeros(size(f));
H(1:n_cutoff)=2*ones(1,n_cutoff);
H(length(f)-n_cutoff+1:length(f))=2*ones(1,n_cutoff);

Z=H.*Y;  % Z: filter output의 스펙트럼
z=real(ifft(Z))*fs;  % filter output waveform
pause
clf

subplot(3,1,1)
plot(f,abs(fftshift(X)))
title('Spectrum of the the Message Signal')

subplot(3,1,2)
plot(f,abs(fftshift(R)))
title('Spectrum of the Received Signal')

subplot(3,1,3)
plot(f,abs(fftshift(Y)))
title('Spectrum of the Mixer Output')
xlabel('Frequency')
pause

clf
subplot(3,1,1)
plot(f,abs(fftshift(Y)))
title('Spectrum of the Mixer Output')

subplot(3,1,2)
plot(f,abs(fftshift(H)))
title('Lowpass Filter Characteristics')

subplot(3,1,3)
plot(f,abs(fftshift(Z)))
title('Spectrum of the Demodulator output')
xlabel('Frequency')
pause

clf
subplot(2,1,1)
plot(f,abs(fftshift(X)))
title('Spectrum of the Message Signal')

subplot(2,1,2)
plot(f,abs(fftshift(Z)))
title('Spectrum of the Demodulator Output')
xlabel('Frequency')
pause
subplot(2,1,1)
plot(t,x(1:length(t)))
title('The Message Signal')

subplot(2,1,2)
plot(t,z(1:length(t)))
title('The Demodulator Output')
xlabel('Time')