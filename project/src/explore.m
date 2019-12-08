close all
clear

data = load("../data/hourly_data.dat");
s = size(data);
n_stations = s(2);
station_array = (1:n_stations-1).';

x = data(3:end, 1);
y = data(3:end, 2:end).';

figure
h = imagesc(x, station_array, y);
h.AlphaData = ones(size(h.CData)); 
h.AlphaData(isnan(h.CData)) = 0;

c = colorbar;
c.Label.String = '°C';
caxis([-max(y(:)) max(y(:))]);

datetick('x')
title("Full Hourly Dataset")
xlabel("Time")
ylabel("Station #")
print('-bestfit','../figures/full_hourly_dataset','-dpdf')

figure
hold on
for i = 10:15
    temp_y = y(i, :);
    msk = ~isnan(temp_y);
    temp_y = temp_y(msk);
    temp_x = x(msk);
    plot(temp_x, movmean(temp_y, 30))
end  
datetick('x')
