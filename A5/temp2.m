close all
fl = .96 / (60*60*24);
fh = 1.04 / (3600*24);
fs = 1/60;



[pxx_deep_summer, f_deep_summer] = ...
    pwelch(james_summer_temps, NFFT, NFFT/2, NFFT, 1/60);

figure()
loglog(f_deep_summer, pxx_deep_summer);
title("Deep Cove Summer PSD")
xlabel('Cycles per day (cpd)')
ylabel('PSD (dB/Hz)')