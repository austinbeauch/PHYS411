close all;
clear;

hourly = "../A3/data/AllStations_temperature_h_2019.dat";

station_lon = 236.417; 
station_lat =  48.620;
start_winter = datenum(2015,11,1,0,0,0);
end_winter   = datenum(2016,3,15,0,0,0);
start_summer = datenum(2016,5,15,0,0,0);
end_summer   = datenum(2016,9,30,0,0,0);

[time_summer, temp_summer] = ...
    getdata(hourly, station_lon, station_lat, start_summer, end_summer);
temp_summer = temp_summer - nanmean(temp_summer);

[time_winter, temp_winter] = ...
    getdata(hourly, station_lon, station_lat, start_winter, end_winter);
temp_winter = temp_winter - nanmean(temp_winter);

% interpolate our records
temp_summer = interpolate(time_summer, temp_summer);
temp_winter = interpolate(time_winter, temp_winter);

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
NFFT = 2048/2^2;
[pxx_winter, f_winter, pxxc_winter] = pwelch(temp_winter, NFFT, NFFT/2, NFFT, 1/3600);
[pxx_summer, f_summer, pxxc_summer] = pwelch(temp_summer, NFFT, NFFT/2, NFFT, 1/3600);

figure(2)
subplot(2,1,1)
hold off;
loglog(f_winter, pxx_winter);
hold on;
loglog(f_winter, pxxc_winter, 'color',[1,0,0,0.2]);
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
title('1 November 2015 to 15 March 2016 PSD with 95%-Confidence Bounds')

subplot(2,1,2)
hold off;
loglog(f_winter, pxxc_summer, 'color',[1,0,1,0.2]);
hold on;
loglog(f_summer, pxx_summer);
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
title('15 May 2016 to 30 September 2016 PSD with 95%-Confidence Bounds')

fSyy_winter = f_winter .* pxx_winter;
fSyy_summer = f_summer .* pxx_summer;
logf_winter = log10(f_winter);
logf_summer = log10(f_summer);

figure(3); hold off;
plot(logf_winter, fSyy_winter);
hold on;
plot(logf_summer, fSyy_summer);
xlabel('Frequency (Hz)');
ylabel('fS_{yy}');
title('Variance Preserving PSDs');
legend('Winter', 'Summer')

% Paresval's theorem
fwinter_int = trapz(logf_winter(2:end), fSyy_winter(2:end));
fsummer_int = trapz(logf_summer(2:end), fSyy_summer(2:end));

time_winter_int = trapz(time_winter, temp_winter.^2) / length(temp_winter);
time_summer_int = trapz(time_summer, temp_summer.^2) / length(temp_summer);

disp("Energy for winter: " + time_winter_int);
disp("PSD Energy for winter: " + fwinter_int);
disp("Energy for summer: " + time_summer_int);
disp("PSD Energy for summer: " + fsummer_int);

function [times, temps] = getdata(path, lon, lat, time_start, time_end)
    data = load(path);
    [hour_rows, hour_cols] = size(data); 
    all_times = data(3:hour_rows,1); 
    station_lon_all = data(1,2:hour_cols); 
    station_lat_all = data(2,2:hour_cols); 
    temperature_data_all = data(3:hour_rows,2:hour_cols);

    diff_lon = abs(station_lon_all - lon);  
    diff_lat = abs(station_lat_all - lat);  

    [~, station_index] = min(diff_lon+diff_lat);
    station_temps = temperature_data_all(:,station_index); 

    index = find(all_times >= time_start & all_times <= time_end);  
    times = all_times(index);
    temps = station_temps(index);
end

function [new_temps] = interpolate(time_in, data_in)
    ii_good = find(~isnan(data_in));
    new_temps = interp1(time_in(ii_good), data_in(ii_good), time_in);
end