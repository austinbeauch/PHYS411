close all;
clear;

world = load("../data/coast.dat");
flipped = flipud(world);
lat = world(:,1);
lon = world(:,2);
lat_out =  flipped(:,1);
lon_out =  flipped(:,2);
plot(lat, lon)
mapshow(lat, lon, 'DisplayType','polygon','FaceColor','green')

mapshow(lat_out, lon_out)
data = load("../data/hourly_data.dat");
x = data(1:2, 2:end);
lon =  data(1:1, 2:end);
lat =  data(2:2, 2:end);
geoshow(lat, lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
