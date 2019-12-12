close all

figure
h = imagesc(all_times, station_array, all_temps);
h.AlphaData = ones(size(h.CData)); 
h.AlphaData(isnan(h.CData)) = 0;

c = colorbar;
c.Label.String = '°C';
caxis([min(all_temps(:)) max(all_temps(:))]);

datetick('x')
title("Full Hourly Dataset")
xlabel("Time")
ylabel("Station #")
yticks(station_array)
a = get(gca,'YTickLabel');
set(gca,'YTickLabel',a,'fontsize',8)
% print('-bestfit','../figures/full_hourly_dataset','-dpdf')
