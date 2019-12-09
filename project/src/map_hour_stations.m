figure
pcolor(lon_trunc,lat_trunc,z_trunc) 
shading interp
ylabel('Latitude [Degrees ^o]')
xlabel('Longitude [Degrees ^o]')
title('Victoria Minutely Data Stations')
qq = [ 0.1 0.5 0.8 ; 0 .5 0];
colormap(qq)
caxis([-150 150])

hold on
contour(lon_trunc, lat_trunc, z_trunc, [0,0], 'k')
geoshow(station_lat, station_lon + 0.035, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])

figure
hold on

mapshow(coast_lon, coast_lat, 'DisplayType','polygon','FaceColor','#77AC30')

geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])