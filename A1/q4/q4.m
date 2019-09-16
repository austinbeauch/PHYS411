close all;
clear;

%----------------------------------------------------------------------------
%--   E:\JOHANNES\Phys411\Matlab_examples\readHourlyData.m
%--
%--   Purpose: to load hourly sampled temperature data
%--    and to extract data for a specific station
%-- 
%--  Input: AllStations_temperature_h.dat
%--
%--   11/09/2018                                       J.Gemmrich
%----------------------------------------------------------------------------

InH = load("data/AllStations_temperature_h_2017.dat");
[NN,MM] = size(InH);  %-- InH has NN rows and MM columns

tt_all = InH(3:NN,1);  %-- time stamps {decimal days,Matlab format] (are in the first column)

Station_lon_all = InH(1,2:MM);  %- longitudes (all stations) (are in the first row)
Station_lat_all = InH(2,2:MM);  %- latitudes (all stations) (are in the second row)

NS = length(Station_lat_all);  %-- number of stations
NT = length(tt_all);           %-- number of data points in each station (number of time stamps)
TTH_all = InH(3:NN,2:MM); %-- matrix with temperature data only.

station_lon = 236.691;  %-- you have to specify this!
station_lat =  48.462;  %-- you have to specify this!

%-- find the station which has the smallest deviation from the desired lat, lon values
diff_lon = abs(Station_lon_all - station_lon);  
diff_lat = abs(Station_lat_all - station_lat);  

[~,iis] = min(diff_lon+diff_lat);
     %-- iis is the index of the desired station (column number in TTH_all)

TTH_s = TTH_all(:,iis);    %-- temperature record at station

tt_start = datenum(2010,1,1,0,0,0);
tt_end   = datenum(2017,8,31,0,0,0);

iit = find(tt_all >= tt_start & tt_all <= tt_end);  %-- indices of desired time stamps

tt  = tt_all(iit);
TTH = TTH_s(iit);

LW = 1;  %-- line width
FS = 18; %-- fontsize

 
figure(1)
 hold on;
 subplot(2,1,1)
 plot(tt, TTH, 'r')
 xlabel('Time [local]')
 ylabel('Temperature [^oC]')
 title( sprintf('%4.3f N, %4.3f W',[Station_lat_all(iis), ...
     360-Station_lon_all(iis)]) )
 datetick('x')

InT = load("data\UVicSci_temperature.dat");

tt_start = InT(1); tt_end = InT(2); NT = InT(3);
tt_minute = linspace(tt_start, tt_end, NT);
data_minute = InT(4:NT+3);

bins = 50;
figure(1)
 subplot(4,1,1)
 
 plot(tt_minute, data_minute)
 xlabel('Time [local]')
 ylabel('Temperature [^oC]')
 title("All Minutely UVic Weather Data")
 datetick('x')
 
figure(1)
 subplot(4,1,2)
 histogram(data_minute, bins, 'Normalization','pdf')
 xlabel('Temperature [^oC]')
 ylabel('Frequency')
 title("Histogram Minutely UVic Weather Data")
 hold on;
 x = (min(data_minute) : 0.1 : max(data_minute));
 y = normpdf(x, nanmean(data_minute), nanstd(data_minute));
 plot(x,y)
 hold off;
  
figure(1)
 subplot(4,1,3)
 plot(tt, TTH, 'r')
 xlabel('Time [local]')
 ylabel('Temperature [^oC]')
 title( sprintf('UVic hourly data: %4.3f N, %4.3f W',[Station_lat_all(iis), ...
     360-Station_lon_all(iis)]) )
 datetick('x')
 
figure(1)
 subplot(4,1,4)
 histogram(TTH, bins, 'Normalization','pdf')
 xlabel('Temperature [^oC]')
 ylabel('Frequency')
 title("Histogram Hourly UVic Weather Data")
 hold on;
 x = (min(TTH) : 0.1 : max(TTH));
 y = normpdf(x, nanmean(TTH), nanstd(TTH));
 plot(x,y)
 hold off;
 
 disp("Minutely mean and std: " + ...
     nanmean(data_minute) + " " + nanstd(data_minute))
 disp("Hourly mean and std: " + nanmean(TTH) + " " + nanstd(TTH))