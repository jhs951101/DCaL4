clear all;
close all;

echo on
df = 0.3;
ts = 1/1000;
fs = 1/ts;
fc = 250;
T1 = -0.1;
T2 = 0.1;
time = [T1:ts:T2];
N = length(time);

tau = 1/20;

x = triangle(tau, T1, T2, fs);  % x: 메시지 신호

xc = cos(2*pi*fc.*time);
xm = x.*xc;

[X,x,df1] = fft_mod(x,ts,df);
X = X/fs;

freq = [0:df1:df1*(length(x)-1)]-fs/2;

[Xm,xm,df1] = fft_mod(xm,ts,df);
Xm = Xm/fs;

[Xc,xc,df1] = fft_mod(xc,ts,df);

dx = lowpass_filter(xm, xc, ts, df, fs, freq);  % dx: LPF를 통과하여 복조된 신호

%

% (1)

plot(time, x(1:length(time)))
title('Message Signal');
pause;

plot(freq, abs(fftshift(X)))
title('Spectrum of Message Signal');
pause;

% (2)

plot(time, xm(1:length(time)))
title('Modulated Signal');
pause;

plot(freq, abs(fftshift(Xm)))
title('Spectrum of Modulated Signal');
pause;

% (3)

plot(time, dx(1:length(time)))
title('Demodulated Signal');