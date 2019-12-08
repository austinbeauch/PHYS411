% ASSUME MINUTE DATA HAS ALREADY BEEN LOADED
% load_minute_data  % if not

close all;

f_samp = 1/60;
figure
for j = n_station_array(1:3)
    temps = all_temps(j, :);
    msk = ~isnan(temps);
    temps_nonan = temps(msk);
    times = all_times_min(msk);
    NFFT = 2^15;
    [pxx, f, pxxc] = pwelch(temps_nonan, NFFT, NFFT/2, NFFT, f_samp);
    s_to_day = 60*60*24;

    subplot(3, 2, j*2-1)
    loglog(f .* s_to_day, pxx);
    xlabel('Cycles per day (cpd)')
    ylabel('H(f)')
    title(labels(j))

    fSyy = f .* pxx;
    subplot(3, 2, j*2)
    semilogx(f .* s_to_day, fSyy);
    xlabel('Frequency (Hz)');
    ylabel('fS_{yy}');
    title('Variance Preserving PSD, ' + labels(j));
end

figure(2)
for j = n_station_array(4:end)
    temps = all_temps(j, :);
    msk = ~isnan(temps);
    temps_nonan = temps(msk);
    times = all_times_min(msk);
    NFFT = 2^15;
    [pxx, f, pxxc] = pwelch(temps_nonan, NFFT, NFFT/2, NFFT, f_samp);
    s_to_day = 60*60*24;

    subplot(4, 2, (j-3)*2-1)
    loglog(f .* s_to_day, pxx);
    xlabel('Cycles per day (cpd)')
    ylabel('H(f)')
    title(labels(j))

    fSyy = f .* pxx;
    subplot(4, 2, (j-3)*2)
    semilogx(f .* s_to_day, fSyy);
    xlabel('Frequency (Hz)');
    ylabel('fS_{yy}');
    title('Variance Preserving PSD, ' + labels(j));
end