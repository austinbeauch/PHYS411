% ASSUME MINUTE DATA HAS ALREADY BEEN LOADED
% load_minute_data  % if not

close all;

f_samp = 1/60;
figure
for i = n_station_array
    temps = all_temps(i, :);
    msk = ~isnan(temps);
    temps_nonan = temps(msk);
    times = times_minute(msk);
    NFFT = 2^15;
    [pxx, f, pxxc] = pwelch(temps_nonan, NFFT, NFFT/2, NFFT, f_samp);
    s_to_day = 60*60*24;

    subplot(7, 2, i*2-1)
    loglog(f .* s_to_day, pxx);
    xlabel('Cycles per day (cpd)')
    ylabel('H(f)')
    title(labels(i))

    fSyy = f .* pxx;
    subplot(7, 2, i*2)
    semilogx(f .* s_to_day, fSyy);
    xlabel('Frequency (Hz)');
    ylabel('fS_{yy}');
    title('Variance Preserving PSD, ' + labels(i));
end