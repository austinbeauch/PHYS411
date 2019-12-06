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

figure
for i = n_station_array
    subplot(3, 3, i)
    temp_y = all_temps(i, :);
    h = histogram(temp_y, 75, 'Normalization','pdf');
    h.LineStyle = 'none';
    title(labels(i))
    xlh = xlabel("Temperature [°C]");
    xlh.Position(2) = xlh.Position(2) + 0.004;
    ylabel("Counts")
end  
suptitle("Approximate PDF Histogram for each Station")
print('-bestfit','../figures/histogram_minute','-dpdf')