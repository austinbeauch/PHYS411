close all;
clear;

station_lon = 236.691; 
station_lat =  48.462;
winter_time_start = datenum(2017,10,28,0,0,0);
winter_time_end   = datenum(2018,1,26,0,0,0);
summer_time_start = datenum(2018,6,1,0,0,0);
summer_time_end   = datenum(2018,9,1,0,0,0);

[winter_time, winter_temp] = ...
    getdata(station_lon, station_lat, winter_time_start, winter_time_end);
[summer_time, summer_temp] = ...
    getdata(station_lon, station_lat, summer_time_start, summer_time_end);

figure(1);
 plot(winter_time, winter_temp, 'b')
 xlabel('Time [Local]')
 ylabel('Temperature [^oC]')
 title('Winter 2017/2018 Temperature');
 xlim([min(winter_time) max(winter_time)])
 datetick('x')

figure(2);
 plot(summer_time, summer_temp, 'r')
 xlabel('Time [Local]')
 ylabel('Temperature [^oC]')
 title('Summer 2018 Temperature');
 datetick('x')
 
winter_rxx = lagcorr(winter_temp);
summer_rxx = lagcorr(summer_temp);

figure(3); hold on;
plot(winter_rxx(:, 1),winter_rxx(:, 2),'b-');
plot(summer_rxx(:, 1),summer_rxx(:, 2),'r-');
plot(xlim, ones(1, 2) ./ exp(1), 'k')
xlabel('Lag (days)')
ylabel('Lag Corr Coef');
title('Lag Correlation Coefficients');
legend({'Winter', 'Summer', '1/e'})

function [times, temps] = getdata(lon, lat, time_start, time_end)
    data = load("../project/data/hourly_data.dat");
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

function rxx = lagcorr(x)
   rxx = [];
   mu = mean(x);
   sigma = std(x);
   N = size(x, 1);
   for k = 0:40*24
       rk = 1/((N-k)*sigma^2)* sum( (x(1:end-k) - mu) .* (x(k+1:end) - mu));
       rxx = [rxx; [k/24, rk]];
   end
end