close all
clear

data = load("../data/hourly_data.dat");
s = size(data);
n_stations = s(2);
station_array = (1:n_stations-1).';
station_lon =  data(1:1, 2:end)-360;
station_lat =  data(2:2, 2:end);

all_times = data(3:end, 1);
all_temps = data(3:end, 2:end).';

load ../data/BCRegion_sm.mat
indslat=find(lat >= 48.3 & lat <= 48.71);
lat_trunc = lat(indslat);
indslon=find(lon <= -123.2 & lon >= -123.8); 
lon_trunc = lon(indslon);
z_trunc = z(indslat, indslon);

coast = load("../data/coast.dat");
[size_grid, ~] = size(coast);
world_flipped = flipud(coast);
coast_lon = coast(:,1);
coast_lat = coast(:,2);
coast_lon_flip = world_flipped(:,1);
coast_lat_flip = world_flipped(:,2);