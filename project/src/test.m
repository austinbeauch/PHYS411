close all;

temps = all_temps(1, :);

t_start_jan = datenum(2017,10,28,0,0,0);
t_end_jan   = datenum(2018,1,26,0,0,0);
t_start_jul = datenum(2018,6,1,0,0,0);
t_end_jul   = datenum(2018,9,1,0,0,0);

[times_jan, temps_jan] = in_range(all_times_min, temps, t_start_jan, t_end_jan);
[times_jul, temps_jul] = in_range(all_times_min, temps, t_start_jul, t_end_jul);

[times_jan, temps_jan] = mask(times_jan, temps_jan);
[times_jul, temps_jul] = mask(times_jul, temps_jul);

rxx_1 = lagcorr(temps_jan);
rxx_2 = lagcorr(temps_jul);

figure(3); hold on;
plot(rxx_1(:, 1),rxx_1(:, 2),'b-');
plot(rxx_2(:, 1),rxx_2(:, 2),'r-');
plot(xlim, ones(1, 2) ./ exp(1), 'k')
xlabel('Lag (days)')
ylabel('Lag Corr Coef');
title('Lag Correlation Coefficients');
legend({'January', 'July', '1/e'})