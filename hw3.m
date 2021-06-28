clear all;
close all;

df = 0.2;
ts = 1/1000;
fs = 1/ts;
fc = 250;

T1 = -0.5;
T2 = 0.5;
time = T1:ts:T2;

N = length(time);

a = 0.85;

m = 2.*cos(5 * pi.*time).*(stepFunction(time + 0.3, ts) - stepFunction(time - 0.3, ts));  % m: 메시지 신호
m_c = cos(2*pi*fc.*time);  % m_c: 반송파
m_m = m.*m_c;  % m_m: 변조된 신호

m_max = max(abs(m));
m_n = m / m_max;

[M, m, df1] = fft_mod(m, ts, df);  % M: 메시지 신호를 FFT 한 값
M = M / fs;

[M_m, m_m, df1] = fft_mod(m_m, ts, df);  % M_m: 변조된 신호를 FFT 한 값
M_m = M_m / fs;

freq = [0:df1:df1*(length(m_m)-1)]-fs/2;

z = hilbert(m_m);  % z: 변조된 신호의 analytic signal
envelope = abs(z);  % envelope: 변조된 신호의 포락선
[Z, z, df1] = fft_mod(z, ts, df);  % Z: analytic signal을 FFT 한 값
Z = Z / fs;

dem = m_max*(envelope-1) / a;  % dem: 포락선 검파기 출력 신호

%

% (1)

plot(time, m(1:length(time)))
title('Message Signal m(t)');
pause;

plot(time, m_m(1:length(time)))
title('Modulated Signal');
pause;

% (2)

plot(time, envelope(1:length(time)))
title('Envelope');
pause;

% (3)

plot(freq, abs(fftshift(M_m)))
title('Spectrum of Modulated Signal');
pause;

plot(freq, abs(fftshift(Z)))
title('Spectrum of Envelope');
pause;

% (4)

plot(time, dem(1:length(time)))
title('Demodulated Signal using Envelope');