%% Interpolation
close all;

%                 y    m  d  h  m  s
date1 = datenum(2011, 10, 1, 10, 0, 0);
date2 = datenum(2012, 2,  1, 10, 0, 0);
date3 = datenum(2012, 6,  1, 10, 0, 0);
date4 = datenum(2012, 9,  1, 10, 0, 0);

date = date3;

while true
    date = date + 0.0417;
    time_index = find(all_times > (date-0.0417/2) & all_times < (date+0.0417/2));
    station_temps = all_temps(:,time_index);
    
%     if sum(isnan(station_temps)) == 1
%         station_temps(isnan(station_temps)) = nanmean(station_temps);
%     end
    
    if ~any(isnan(station_temps)) % & any(station_temps<0)
        break;
    end
end

[XX_size, ~] = size(coast_lon);
[YY_size, ~] = size(coast_lat);
[XX_grid,YY_grid] = meshgrid(coast_lon, coast_lat, "cubic");

gridded_data = griddata(station_lon, station_lat, station_temps, XX_grid, YY_grid);

figure
hold on
subplot(4,1,1)
mapshow(coast_lon, coast_lat, 'DisplayType','polygon','FaceColor','g')
h = pcolor(XX_grid,YY_grid,gridded_data);
set(h, 'EdgeColor', 'none');
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', 'w')
title("Cubic Interpolation " + datestr(date,'yyyy-mm-dd HH:MM'))
xlabel('Longitude')
ylabel('Latitude')
xlim([-123.75 -123.29])
ylim([48.3 48.7])
daspect([cosd(48.5) cosd(48.5) 1])
c = colorbar;
c.Label.String = 'Temperature [^{o}C]';
caxis([0 20]);
% caxis([min(all_temps(:)) max(all_temps(:))]);


%% Global fitting

r_sqr_grid = zeros(XX_size,YY_size);
for ii = 1:XX_size
    for jj = 1:YY_size
        r_sq = ((coast_lon(ii) - station_lon).^2 + (coast_lat(jj)-station_lat).^2);
        w = 1 ./ r_sq;
        w = w ./ sum(w);
        r_sqr_grid(jj, ii) = w * station_temps;
    end
end

subplot(4,1,3)
hold on 
colormap('parula')
pcolor(XX_grid, YY_grid, r_sqr_grid)
shading('flat')
plot(coast_lon,coast_lat)
plot(station_lon,station_lat,'k.')
title({'Inversve Square Distance Global Gridding, 1/r^2 ',datestr(date,'yyyy-mm-dd HH:MM')})
xlabel('Longitude')
ylabel('Latitude')
c = colorbar;
caxis([0 20]);
% caxis([min(all_temps(:)) max(all_temps(:))]);
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', 'w')
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
xlim([-123.75 -123.29])
ylim([48.3 48.7])
daspect([cosd(48.5) cosd(48.5) 1])

sig = 0.1;
r_sqr_grid = zeros(XX_size,YY_size);
for ii = 1:XX_size
    for jj = 1:YY_size
        rr_sq = ((coast_lon(ii) - station_lon).^2 + (coast_lat(jj)-station_lat).^2);
        ww = exp(-rr_sq./(2*sig^2));
        ww = ww ./ sum(ww);
        r_sqr_grid(jj,ii) = sum(ww * station_temps);
    end
end

lin1 = linspace(min(coast_lon), max(coast_lon), 3500);
lin2 = linspace(min(coast_lat), max(coast_lat), 3500);
[XX_grid_big,YY_grid_big] = meshgrid(lin1, lin2, "cubic");
nearest = griddata(station_lon, station_lat, station_temps, XX_grid_big, YY_grid_big, 'nearest');

subplot(4,1,4)
hold on 
colormap('parula')
pcolor(XX_grid, YY_grid, r_sqr_grid)
shading('flat')
plot(coast_lon,coast_lat)
plot(station_lon,station_lat,'k.')
title({"Exponential Global Gridding, e^{-r^{2}/2\sigma^{2}}, \sigma="+sig,datestr(date,'yyyy-mm-dd HH:MM')})
xlabel('Longitude')
ylabel('Latitude')
c = colorbar;
caxis([0 20]);
% caxis([min(all_temps(:)) max(all_temps(:))]);
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', 'w')
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
xlim([-123.75 -123.29])
ylim([48.3 48.7])
daspect([cosd(48.5) cosd(48.5) 1])

subplot(4,1,2)
hold on
mapshow(coast_lon, coast_lat, 'DisplayType','polygon','FaceColor','g')
h = pcolor(XX_grid_big ,YY_grid_big, nearest);
set(h, 'EdgeColor', 'none');
voronoi(station_lon, station_lat)
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', 'w')
title("Nearest Neighbor Interpolation " + datestr(date,'yyyy-mm-dd HH:MM'))
xlabel('Longitude')
ylabel('Latitude')
xlim([-123.75 -123.29])
ylim([48.3 48.7])
daspect([cosd(48.5) cosd(48.5) 1])
c = colorbar;
c.Label.String = 'Temperature [^{o}C]';
caxis([0 20]);

% print('-fillpage','../figures/gridding_fall','-dpdf')
