close all;

interp_type = "cubic";

date = datenum(2016,6,0,0,0,0);
time_index = find(all_times > (date-0.0417) & all_times < (date+0.0417));
station_temps = all_temps(:,time_index);
if any(isnan(station_temps))
    error("Contains a nan")
end
[XX_size, ~] = size(coast_lon);
[YY_size, ~] = size(coast_lat);
[XX_grid,YY_grid] = meshgrid(coast_lon, coast_lat, interp_type);

gridded_data = griddata(station_lon, station_lat, station_temps, XX_grid, YY_grid);

figure
hold on
mapshow(coast_lon, coast_lat, 'DisplayType','polygon','FaceColor','#77AC30')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])
h = pcolor(XX_grid,YY_grid,gridded_data);
set(h, 'EdgeColor', 'none');
title(interp_type + " Interpolation on " + datestr(all_times(time_index)))
c = colorbar;
c.Label.String = 'Temperature [^{o}C]';
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')

xlabel('Longitude')
ylabel('Latitude')