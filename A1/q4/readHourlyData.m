fdrivein = 'data\';  %-- file input directory (need to specify this)
fnamein = 'AllStations_temperature_h_2017';   %-- name of input file (with data for all stations)
extin = '.dat';                          %-- extension of input file name

InH = load([fdrivein,fnamein,extin]);
[NN,MM] = size(InH);  %-- InH has NN rows and MM columns

tt_all = InH(3:NN,1);  %-- time stamps {decimal days,Matlab format] (are in the first column)

Station_lon_all = InH(1,2:MM);  %- longitudes (all stations) (are in the first row)
Station_lat_all = InH(2,2:MM);  %- latitudes (all stations) (are in the second row)

NS = length(Station_lat_all);  %-- number of stations
NT = length(tt_all);           %-- number of data points in each station (number of time stamps)


%-------------------------------------------------------
%-- There are NS different stations in this data set
%-- each station is 1 column
%--------------
%-- first 2 rows give longitude and latitude for each station
%--------------
%-- first column gives time stamps
%-------------------------------------------------------

 %-- so this leaves NN-2 data points (temperature) for each station
 
 TTH_all = InH(3:NN,2:MM); %-- matrix with temperature data only.
 
% station_lon = 236.5430;  %-- you have to specify this!
% station_lat =  48.6804;  %-- you have to specify this!

%(for another station this might be as follows:)
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

figure(1)
 plot(tt,TTH)
 xlabel('Time [local]')
 ylabel('Temperature [^oC]')
 title( sprintf('%4.3f N, %4.3f W',[Station_lat_all(iis),360-Station_lon_all(iis)]) )

LW = 1;  %-- line width
FS = 18; %-- fontsize

figure(2),clf,land  %-- set paper orientation to landscape
 plot(tt,TTH,'r-','linewidth',LW)
 xlabel('Time [local]')
 ylabel('Temperature [^oC]')
 title( sprintf('%4.3f N, %4.3f W',[Station_lat_all(iis),360-Station_lon_all(iis)]) )
 datetick('x')
 fontchan(FS)

