close all;

winter_time_start = datenum(2016,10,28,0,0,0);
winter_time_end   = datenum(2017,1,26,0,0,0);

temps_1 = all_temps(3, :);

[times_1, temps_1] = in_range(all_times_min, temps_1, winter_time_start, winter_time_end);
[times_1, temps_1] = mask(times_1, temps_1);


[acf,lags,bounds] = autocorr(temps_1);
plot(acf, lags)