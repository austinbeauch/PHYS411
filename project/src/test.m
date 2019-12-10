close all

coast_lon_flip = world_flipped(:,1);
coast_lat_flip = world_flipped(:,2);

idx=find(coast_lon <= -123.2 & coast_lon >= -123.8); 
coast_lon_trunc = coast_lon(idx);

idx=find(coast_lat >= 48.3 & coast_lat <= 48.71);
coast_lat_trunc = coast_lat(idx);

[XX_size, ~] = size(coast_lon);
[YY_size, ~] = size(coast_lat);
[XX_grid,YY_grid] = meshgrid(coast_lon,coast_lat);

figure
hold on
set(gca,'Color','b')
mapshow(coast_lon, coast_lat, 'DisplayType','polygon','FaceColor','#77AC30')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])
xlim([-123.75 -123.26])
ylim([48.3 48.7])

figure
% geoshow(coast_lon_flip, coast_lat_flip)
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', 'w')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])
xlim([-123.75 -123.26])
ylim([48.3 48.7])

