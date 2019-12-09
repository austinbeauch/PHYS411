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

world = load("../data/coast.dat");
flipped = flipud(world);
coast_lon = world(:,1);
coast_lat = world(:,2);

% idx=find(coast_lon <= -123.2 & coast_lon >= -123.8); 
% coast_lon = coast_lon(indslon);
% 
% idx=find(coast_lat >= 48.3 & coast_lat <= 48.71);
% coast_lat = coast_lat(indslat);
