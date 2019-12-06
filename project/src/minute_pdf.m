% ASSUME MINUTE DATA HAS ALREADY BEEN LOADED
% load_minute_data  % if not

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