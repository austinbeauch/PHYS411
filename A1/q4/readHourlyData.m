fdrivein = 'data\';  %-- file input directory (need to specify this)
fnamein = 'AllStations_temperature_h_2017';   %-- name of input file (with data for all stations)
extin = '.dat';                          %-- extension of input file name

%% Assignament 1, Question 4 only 2012

% Minute analysis

clc; % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.

Min_data = load('data\UVicSci_temperature.dat');
%parsing
start_minute = Min_data(1);
end_minute = Min_data(2);
data_pts = Min_data(3);
timeSpan_mins = linspace(start_minute, end_minute, data_pts);
temp_data = Min_data([4:data_pts+3]);

start_minute = datenum(2012,1,1,0,0,0);
end_minute = datenum(2012,12,31,23,59,59);

time_index = find(timeSpan_mins >= start_minute & timeSpan_mins <= end_minute);

time_min  = timeSpan_mins(time_index);
temp_min = temp_data(time_index);


%histogram plot
rang= [-10: .1: 40];
norm_1 = normpdf(rang, 9.997, 5.009);
figure(3); hold on;
histogram(temp_min,100,'Normalization', 'pdf');
plot(rang, norm_1, 'linewidth',3)
title('Minute data for 2012')
xlabel('Temperature [^oC]')
ylabel('Events')
fontchan(18)

%prints sample mean and std
mns_1 = samMeanStd(temp_min);
display(sprintf('Minute resolution mean %4.3f [Celsius], %4.3f [Celsius]',[mns_1(1), mns_1(2)]));



All_hour_data = load("data/AllStations_temperature_h_2017.dat");


[rows,cols] = size(All_hour_data);  %-- InH has NN rows and MM columns


%---------------------------
%-- seperate input matrix into time stamps, station coordinates and temperature data
%---------------------------


tt_all = All_hour_data(3:rows,1);  %-- time stamps {decimal days,Matlab format] (are in the first column)

Station_lon_all = All_hour_data(1,2:cols);  %- longitudes (all stations) (are in the first row)
Station_lat_all = All_hour_data(2,2:cols);  %- latitudes (all stations) (are in the second row)


Num_stations = length(Station_lat_all);  %-- number of stations
data_pts_per_station = length(tt_all);   %-- number of data points in each station (number of time stamps)



%-------------------------------------------------------
%-- There are NS different stations in this data set
%-- each station is 1 column
%--------------
%-- first 2 rows give longitude and latitude for each station
%--------------
%-- first column gives time stamps
%-------------------------------------------------------

 %-- so this leaves NN-2 data points (temperature) for each station
 
 all_temps = All_hour_data(3:rows,2:cols); %-- matrix with temperature data only.
 

%--------------------------
%-- pick 1 specific stations, based on its coordinates
%--------------------------

station_lon = 236.691;  %-- you have to specify this!
station_lat =  48.462;  %-- you have to specify this!

%(for another station this might be as follows:)
% % station_lon = 236.691;  %-- you have to specify this!
% % station_lat =  48.462;  %-- you have to specify this!


%-- find the station which has the smallest deviation from the desired lat, lon values
diff_lon = abs(Station_lon_all - station_lon);  
diff_lat = abs(Station_lat_all - station_lat);  

[~,station_index] = min(diff_lon+diff_lat);
     %-- iis is the index of the desired station (column number in TTH_all)


 station_temp = all_temps(:,station_index);    %-- temperature record at station


%---------------------------------------------
%-- Next, find a specific time interval
%---------------------------------------------

tt_start = datenum(2012,1,1,0,0,0);
tt_end   = datenum(2012,12,31,23,59,59);


time_index = find(tt_all >= tt_start & tt_all <= tt_end);  %-- indices of desired time stamps


time_i  = tt_all(time_index);
temp_i = station_temp(time_index);


%--------------------

%-- display time series with some custom settings 
%-- (need to download 'land.m', 'port.m' and 'fontchan.m' from course home page
%--------------------


%histogram plot
figure(4); hold on;
norm_2 = normpdf(rang, 10.000, 5.008);
histogram(temp_i,100,'Normalization', 'pdf')
plot(rang, norm_2, 'linewidth',3)
title('Hour data for 2012')
xlabel('Temperature [^oC]');
ylabel('Events')
fontchan(18)


