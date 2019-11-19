close all;
clear; 

n = 3e4;
t = linspace(-15, 15, n);
fs = n/30;

a1 = 22;
a2 = 14;
a3 = 147;

f1 = @(t) cos(a1*pi*t);
f = @(t) f1(t) + 0.7 * sin(a2*pi*t) + 0.5*sin(a3*pi*t);

x1 = f1(t);
x = f(t);
nfft = 2^(nextpow2(length(x))-1);

mask = (-1<t & t<1);

figure(1)
plot(t(mask), x(mask))
xlabel("t")
ylabel("x(t)")
title("x(t) from -1s to 1s")

figure(2)
[pxx, w] = pwelch(x, nfft, nfft/2, nfft, fs, 'onesided');
loglog(w, pxx);
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
title("Power Density Spectrum of x(t)")

fc = [10 20];
order = 5;
[b,a] = butter(order ,fc/(fs/2));

figure(3)
[Hf, wf] = freqz(b,a);
plot(wf, abs(Hf))
title("Frequency response of Butterworth filter")
xlabel("Frequency (Hz)")
ylabel("Response")

figure(4)
hold on;
filtered = filtfilt(b, a, x);
plot(t(mask), x1(mask))
plot(t(mask), filtered(mask))
title("Filtered x(t), Butterworth filter order: " + order + "; Cutoff frequencies: " + fc(1) + "," + fc(2) +"Hz")
xlabel("H(\omega)")
ylabel("Time")
legend({'x_{1}(t)', 'Recovered'})

figure(5)
hold off;
loglog(w, pxx);
hold on;
[pxx2, w2] = pwelch(filtered, nfft, nfft/2, nfft, fs);
loglog(w2, pxx2);
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
title("PDS of x(t) and x(t) filtered")
legend({'x(t)', 'x_{f}(t)'})

figure(6)
plot(t, filtered - x1)
xlabel("t")
ylabel("x_{f}(t) - x_{1}(t)")
title("Difference between filtered and original time series")
