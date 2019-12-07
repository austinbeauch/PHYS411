% ASSUME MINUTE DATA HAS ALREADY BEEN LOADED
% load_minute_data  % if not
close all

figure
hold on
for i = n_station_array
    temp_y = all_temps(i, :);
    msk = ~isnan(temp_y);
    temp_y = temp_y(msk);
    time_nonan = times_minute(msk);
    smoothed = movmean(temp_y, 50000);
    p = plot(time_nonan, smoothed);
    p.Color(4) = 0.8;
end  
datetick('x')
legend(labels)
title("Smoothed Minute Resolution Time Searies")
xlabel("Time")
ylabel("Temperature [°C]")
% print('-bestfit','../figures/smoothed_minute','-dpdf')

figure
hold on
for i = n_station_array
    subplot(3,3,i)
    temp_y = all_temps(i, :);
    p = plot(times_minute, temp_y);
    p.Color(4) = 0.8;
    xlabel("Time")
    ylabel("Temperature [°C]")
    title(labels(i))
    datetick('x')
    xlim([datenum(2010,1,1,0,0,0) datenum(2019,2,31,23,59,59)]);
end  
suptitle("Full Time Series")

% print('-fillpage','../figures/minute_all_temperatures','-dpdf')