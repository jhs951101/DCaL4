clear all;
close all;

echo on
df = 0.3;
ts = 1/1000;
fs = 1/ts;
fc = 250;
T1 = -0.1;
T2 = 0.1;
t = [T1:ts:T2];
N = length(t);

snr=20;
snr_lin=10^(snr/10);

tau = 0.1;

x = sinc(t, ts, tau);  % x: 메시지 신호

xc = cos(2*pi*fc.*t);  % xc: 반송파 신호
xm = x.*xc;  % xm: 변조된 신호  
[X,x,df1] = fft_mod(x,ts,df);  % X: 메시지 신호를 FFT 한 값
X = X/fs;

f = [0:df1:df1*(length(x)-1)]-fs/2;

[Xm,xm,df1] = fft_mod(xm,ts,df);  % Xm: 변조된 신호를 FFT 한 값
Xm = Xm/fs;

[XC,xc,df1] = fft_mod(xc,ts,df);  % XC: 반송파 신호를 FFT 한 값

signal_power = norm(xm(1:N))^2/N;  % signal_power: 신호 전력
noise_power = signal_power/snr_lin;
noise_std = sqrt(noise_power);
noise = noise_std*randn(1,length(xm));

r = xm+noise;
[R,r,df1] = fft_mod(r,ts,df);
R = R/fs;

% (4)
signal_power
pause

%

% (1)

plot(t,x(1:length(t)))
xlabel('Time')
title('Message signal')
pause

% (3)

plot(f,abs(fftshift(X)))
xlabel('Frequency')
title('Spectrum of the message signal')
pause

% (5)

plot(t,xm(1:length(t)))
xlabel('Time')
title('Modulated signal')
pause

plot(f,abs(fftshift(Xm)))
title('Spectrum of the modulated signal')
xlabel('Frequency')
