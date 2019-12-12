close all
%%
clear
load_hour_data

min_lat_lon = min(coast);
min_lat = min_lat_lon(2)-0.05;
min_lon = min_lat_lon(1);

max_lat_lon = max(coast);
max_lat = max_lat_lon(2);
max_lon = max_lat_lon(1);

% the grid
[XX_grid,YY_grid] = meshgrid(coast_lon, coast_lat);

%% Clean data
try
    station_lat(:,[20,26,29,33,35,37,38]) = [];
    station_lon(:,[20,26,29,33,35,37,38]) = [];
    all_temps([20,26,29,33,35,37,38], :) = [];
catch
    warning("Already removed stations")
end

all_temps = all_temps';
[rows,columns] = size(all_temps);
for row = 1:rows
    isNaN = find(isnan(all_temps(row,:)));
    all_temps(row,isNaN) = nanmean(all_temps(row,:));   
end

for column = 1:columns
  iis = find(isnan(all_temps(:,column)));
  all_temps(iis,column) = nanmean(all_temps(:,column));
end

%% EOF analysis
temps_cov = cov(all_temps);
[Evec, Eval] = eig(temps_cov);
[NE, ME] = size(Evec);

for ii=1:ME
    [Evec_max, iim] = max(abs(Evec(:, ii)));
    Evec(:, ii) = Evec(:, ii)/Evec(iim, ii);
end

[Eval_sort, ind] = sort(-diag(Eval));
%%
weights = Eval_sort/sum(Eval_sort).*100;
mode1 = weights(1,1);
mode2 = weights(2,1);
mode3 = weights(3,1);

%%
EOFs = zeros(length(all_temps) ,3);
for ii = 1:3
    EOFs(:,ii) =  Evec(:,ind(ii))' * all_temps';
end
EOFs = EOFs ./ max(EOFs(:));  %-- normalize amplitudes (eigenvalues)

%%
XX_size = length(coast_lon);
YY_size = length(coast_lon);
zz = zeros(XX_size, YY_size);
for ii = 1:XX_size
    for jj = 1:YY_size
        r_sq = ((coast_lon(ii) - station_lon).^2 + (coast_lat(jj)-station_lat).^2);
        w = 1 ./ r_sq;
        w = w ./ sum(w);
        zz(jj, ii) = w *  Evec(:,32);
    end
end

figure
subplot(311)
pcolor(XX_grid, YY_grid, zz)
shading('flat')
hold on 
plot(coast_lon,coast_lat)
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', [0.8 0.8 0.8])
title(sprintf('Mode 1, %.1f %', mode1))
xlabel('Longitude')
ylabel('Latitude')
xlim([-123.75 -123.29])
ylim([48.3 48.7])
daspect([cosd(48.5) cosd(48.5) 1])

XX_size = length(coast_lon);
YY_size = length(coast_lon);
zz = zeros(XX_size, YY_size);
for ii = 1:XX_size
    for jj = 1:YY_size
        r_sq = ((coast_lon(ii) - station_lon).^2 + (coast_lat(jj)-station_lat).^2);
        w = 1 ./ r_sq;
        w = w ./ sum(w);
        zz(jj, ii) = w *  Evec(:,31);
    end
end

subplot(312)
pcolor(XX_grid,YY_grid,zz)
shading('flat')
hold on 
plot(coast_lon,coast_lat)
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', [0.8 0.8 0.8])
title(sprintf('Mode 2, %.1f %', mode2))
xlabel('Longitude')
ylabel('Latitude')
xlim([-123.75 -123.29])
ylim([48.3 48.7])
daspect([cosd(48.5) cosd(48.5) 1])
 
XX_size = length(coast_lon);
YY_size = length(coast_lon);
zz = zeros(XX_size, YY_size);
for ii = 1:XX_size
    for jj = 1:YY_size
        r_sq = ((coast_lon(ii) - station_lon).^2 + (coast_lat(jj)-station_lat).^2);
        w = 1 ./ r_sq;
        w = w ./ sum(w);
        zz(jj, ii) = w *  Evec(:,30);
    end
end

subplot(313)
pcolor(XX_grid,YY_grid,zz)
shading('flat')
hold on 
plot(coast_lon,coast_lat)
geoshow(station_lat, station_lon, 'Marker', '.', 'Color', 'red', 'LineStyle','none')
geoshow(coast_lat_flip, coast_lon_flip, 'DisplayType', 'polygon', 'FaceColor', [0.8 0.8 0.8])
title(sprintf('Mode 3, %.1f %', mode3))
xlabel('Longitude')
ylabel('Latitude')
xlim([-123.75 -123.29])
ylim([48.3 48.7])
daspect([cosd(48.5) cosd(48.5) 1])

%%
figure
plot(all_times,EOFs(:,1))
hold on
plot(all_times,EOFs(:,2))
plot(all_times,EOFs(:,3))
title('Empirical Mode Amplitudes')
xlabel('Time')
ylabel('Temperature [^{o}C]')
xlim([all_times(1) all_times(end)])
datetick('x')
legend('Mode 1','Mode 2','Mode 3','location','southeast')

%%
maxlag = 24*365*8;

autoCov_mode1 = xcov(EOFs(:,1),EOFs(:,1),maxlag,'coeff');
autoCov_mode2 = xcov(EOFs(:,2),EOFs(:,2),maxlag,'coeff');
autoCov_mode3 = xcov(EOFs(:,3),EOFs(:,3),maxlag,'coeff');

xlength = -length(autoCov_mode1)/2:1:length(autoCov_mode1)/2-1;

rxy = linspace(exp(-1),exp(-1),length(autoCov_mode1));
r_xy = -rxy;
% normalize xlength to days 
xlength = xlength.*(1/24).*(1/365);
figure
subplot(3,1,1)
plot(xlength,rxy)
hold on
plot(xlength,autoCov_mode1)
title('Auto Correlation, Mode 1')
xlabel('Lag [Years]')
ylabel('Correlation')
xlim([xlength(1) xlength(end)])
ylim([-1 1])
legend('e^{-1}')

subplot(3,1,2)
plot(xlength,rxy)
hold on
plot(xlength,autoCov_mode2)
title('Auto Correlation, Mode 2')
xlabel('Lag [Years]')
ylabel('Correlation')
xlim([xlength(1) xlength(end)])
ylim([-1 1])
legend('e^{-1}')

subplot(3,1,3)
plot(xlength,rxy)
hold on
plot(xlength,autoCov_mode3)
title('Auto Correlation, Mode 3')
xlabel('Lag [Years]')
ylabel('Correlation')
xlim([xlength(1) xlength(end)])
ylim([-1 1])
legend('e^{-1}')

