close all;
clear;

load ../data/BCRegion_sm.mat

data = load("../data/hourly_data.dat");
x = data(1:2, 2:end);
station_lon =  data(1:1, 2:end);
station_lat =  data(2:2, 2:end);

figure()
indslat=find(lat >= 48.3 & lat <= 48.71);
shortlat = lat(indslat);
indslon=find(lon <= -123.2 & lon >= -123.8); 
shortlon = lon(indslon);
shortz = z(indslat, indslon);
pcolor(shortlon,shortlat,shortz) 

shading interp
ylabel('Latitude [Degrees ^o]')
xlabel('Longitude [Degrees ^o]')
title('Victoria Minutely Data Stations')
qq = [ 0.1 0.5 0.8 ; 0 .5 0];
colormap(qq)
caxis([-150 150])
hold on
contour(shortlon, shortlat, shortz, [0,0], 'k')
minute_lat = [48.679131, 48.653245, 48.389155, 48.417489, 48.370919, 48.566595, 48.463444];
minute_lon = [-123.472440, -123.651902, -123.728822, -123.383688, -123.749399, -123.403815, -123.311745];
minute_station = {'Deep Cove', 'Discovery Elementary', 'Helgesen', 'James Bay', 'John Muir', 'Keating', 'UVic'};
% scatter(minute_lon + 0.03, minute_lat, 'ko', 'markerfacecolor', 'w', 'linewidth', 0.7)
geoshow(station_lat, station_lon + 0.035, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])
