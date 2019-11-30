close all;

fs = 1/60;
n  = 4;     % order
Rp = .05;  % Peak-to-peak passband ripple
Rs = 100;  % Stopband attenuation
Wp_high = 1.05 / 86400;
Wp_low = 0.95 / 86400;

[b_low, a_low] = ellip(n, Rp, Rs, Wp_low/(fs/2));
[H_low, w_low] = freqz(b_low, a_low);

[b_high, a_high] = ellip(n, Rp, Rs, Wp_high/(fs/2), 'high');
[H_high, w_high] = freqz(b_high, a_high);

figure()
plot(w_high, abs(H_high))
hold on 
plot(w_low, abs(H_low))
xlabel("Frequency (CPD)")
ylabel("Response")
xlim([-0.01 0.2])
ylim([0 1.01])
title("Filter frequency response")
legend(["Lowpass", "Highpass"])

figure()
hold on;
deep_summer_filtered = filtfilt(b_low, a_low, deep_summer_temps_nanfree);
deep_summer_filtered = filtfilt(b_high, a_high, deep_summer_filtered);
plot(deep_summer_times_nanfree, deep_summer_temps_nanfree)
plot(deep_summer_times_nanfree, deep_summer_filtered)
title("Filtered x(t)")
xlabel('Time')
ylabel('Temperature [^oC]')
legend({'Time data', 'Filtered Response'})
datetick('x')

NFFT = 2^14;
[pxx, f] = ...
    pwelch(deep_summer_filtered, NFFT, NFFT/2, NFFT, fs);

figure()
loglog(f_deep_summer * s_to_day, pxx_deep_summer)
hold on
loglog(f*s_to_day, pxx)
















