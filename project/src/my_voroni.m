close all

date = datenum(2017, 10, 1, 2, 0, 0);
while true
    date = date + 0.0417;
    time_index = find(all_times > (date-0.0417/2) & all_times < (date+0.0417/2));
    station_temps = all_temps(:,time_index);
    if ~any(isnan(station_temps)) % & any(station_temps<0)
        break;
    end
end

x = station_lon;
y = station_lat;

figure
hold on
mapshow(coast_lon, coast_lat)
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
set(gca, 'dataaspectRatio', [1 cos(49*pi/180) 1])
xlim([-123.75 -123.26])
ylim([48.3 48.7])
% voronoi(x,y)

interp_type = "cubic";
[XX_size, ~] = size(coast_lon);
[YY_size, ~] = size(coast_lat);
[XX_grid,YY_grid] = meshgrid(coast_lon, coast_lat);

nearest = zeros(XX_size,YY_size);
for ii = 1:XX_size
    for jj = 1:YY_size
        r_sq = ((coast_lon(ii) - station_lon).^2 + (coast_lat(jj)-station_lat).^2);
        min_idx = find(r_sq == min(r_sq));
        nearest(jj, ii) = station_temps(min_idx(1));
    end
end

figure
colormap('parula')
pcolor(XX_grid, YY_grid, nearest)
shading('flat')
hold on 
plot(coast_lon,coast_lat)
plot(station_lon,station_lat,'k.')
title('Nearest Neighbor Interpolation')
xlabel('Longitude')
ylabel('Latitude')
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', 'w')
xlim([-123.75 -123.29])
ylim([48.3 48.7])
daspect([cosd(48.5) cosd(48.5) 1])
c = colorbar;
c.Label.String = 'Temperature [^{o}C]';
caxis([min(nearest(:)) max(nearest(:))]);

voronoi(x,y);
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', 'w')
