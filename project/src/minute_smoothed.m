% ASSUME MINUTE DATA HAS ALREADY BEEN LOADED
% load_minute_data  % if not
close all

figure
hold on
for i = n_station_array
    temp_y = all_temps(i, :);
    mask = ~isnan(temp_y);
    temp_y = temp_y(mask);
    time_nonan = times_minute(mask);
    smoothed = movmean(temp_y, 50000);
    p = plot(time_nonan, smoothed);
    p.Color(4) = 0.8;
end  
datetick('x')
legend(labels)
title("Smoothed Minute Resolution Time Searies")
xlabel("Time")
ylabel("Temperature [°C]")
print('-bestfit','../figures/smoothed_minute','-dpdf')
