figure
hold on
mapshow(coast_lon, coast_lat, 'DisplayType','polygon','FaceColor','#77AC30')
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', 'b')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])
xlim([-123.75 -123.26])
ylim([48.3 48.7])