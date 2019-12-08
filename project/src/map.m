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
geoshow(station_lat, station_lon + 0.035, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])
