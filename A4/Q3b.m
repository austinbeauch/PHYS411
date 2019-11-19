close all;
clear

start_winter = datenum(2015,11,1,0,0,0);
end_winter   = datenum(2016,3,15,0,0,0);
start_summer = datenum(2016,5,15,0,0,0);
end_summer   = datenum(2016,9,30,0,0,0);

[time_winter, temp_winter] = getminute("JamesBay_temperature_2019.dat", start_winter, end_winter);
[time_summer, temp_summer] = getminute("JamesBay_temperature_2019.dat", start_summer, end_summer);
temp_winter = temp_winter - nanmean(temp_winter);
temp_summer = temp_summer - nanmean(temp_summer);

% this record still have NaN's at the end of the set
mask = ~isnan(temp_winter);
temp_winter = temp_winter(mask);
time_winter = time_winter(mask);

mask = ~isnan(temp_summer);
temp_summer = temp_summer(mask);
time_summer = time_summer(mask);

figure(1)
hold on;
plot(time_summer, temp_summer)
plot(time_winter, temp_winter)
xlabel('Time')
ylabel('Temperature [^oC]')
title('Mean-Removed Datasets');
datetick('x')

% chosen to reduce noise and tighten the confidence interval
NFFT = 2^12;
[pxx_winter, f_winter, pxxc_winter] = pwelch(temp_winter, NFFT, NFFT/2, NFFT, 1/60);
[pxx_summer, f_summer, pxxc_summer] = pwelch(temp_summer, NFFT, NFFT/2, NFFT, 1/60);

s_to_day = 60*60*24;

figure(2)
subplot(2,1,1)
hold off;
loglog(f_winter .* s_to_day, pxx_winter);
hold on;
loglog(f_winter .* s_to_day, pxxc_winter, 'color',[0,0,0,0.2]);
xlabel('Cycles per day (cpd)')
ylabel('PSD (dB/Hz)')
title('Winter Minute PSD with 95%-Confidence Bounds')

subplot(2,1,2)
hold off;
loglog(f_winter .* s_to_day, pxxc_summer, 'color',[0,0,0,0.2]);
hold on;
loglog(f_summer .* s_to_day, pxx_summer);
xlabel('Cycles per day (cpd)')
ylabel('PSD (dB/Hz)')
title('Summer Minute PSD with 95%-Confidence Bounds')

function [times, temps] = getminute(fname, time_start, time_end)
    minute_data = load(fname);
    minute_time_start = minute_data(1);
    minute_time_end = minute_data(2); 
    minute_data_points = minute_data(3);
    all_minute_times = linspace(minute_time_start, minute_time_end, minute_data_points) - 7/24;
    all_minute_temperatures = minute_data(4:minute_data_points+3);
    minute_index = find(all_minute_times >= time_start & all_minute_times <= time_end); 
    times = all_minute_times(minute_index);
    temps= all_minute_temperatures(minute_index);
end