% ASSUME MINUTE DATA HAS ALREADY BEEN LOADED
% load_minute_data  % if not

close all

figure
h = imagesc(times_minute, n_station_array, all_temps);
h.AlphaData = ones(size(h.CData)); 
h.AlphaData(isnan(h.CData)) = 0;
c = colorbar;
c.Label.String = '°C';
caxis([-max(all_temps(:)) max(all_temps(:))]);

datetick('x')
title("Full Minutely Dataset")
xlabel("Time")
xtickangle(45)
ylabel("Station")
yticklabels(labels)

% saveas(gcf,'../figures/full_minutely_dataset.png')
% print('-bestfit','../figures/full_minutely_dataset','-dpdf')

%% Stats
disp("Stats per station:")
for i = n_station_array
    tmp = all_temps(i, :);
    disp(labels(i) + ":  Mean = " + round(nanmean(tmp),2) + "°C , std = " + round(nanstd(tmp),2) + "°C" )
end