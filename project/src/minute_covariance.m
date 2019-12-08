close all;

winter_time_start = datenum(2016,10,28,0,0,0);
winter_time_end   = datenum(2017,1,26,0,0,0);
summer_time_start = datenum(2017,6,1,0,0,0);
summer_time_end   = datenum(2017,9,1,0,0,0);

t_start = winter_time_start;
t_end = winter_time_end;

k = 4;
i = 6;

figure
t_start = winter_time_start;
t_end = winter_time_end;
[c, lags] = covariance_in(all_temps, all_times_min, 7, i, t_start, t_end, winter_time_end);
subplot(2, 1, 1)
hold on
plot(lags ./ (24*60), c)
plot(xlim, ones(1, 2) ./ exp(1), 'k--')
xlabel('Lag (days)')
ylabel('Autocovariances');
title("Cross Covariance: " + labels(k) + ", " + labels(i) +" from "+ datestr(t_start) + " to " + datestr(t_end));
legend({'Corr', '1/e'})

t_start = summer_time_start;
t_end = summer_time_end;
[c, lags] = covariance_in(all_temps, all_times_min, 7, i, t_start, t_end, winter_time_end);
subplot(2, 1, 2)
hold on
plot(lags ./ (24*60), c)
plot(xlim, ones(1, 2) ./ exp(1), 'k--')
xlabel('Lag (days)')
ylabel('Autocovariances');
title("Cross Covariance: " + labels(k) + ", " + labels(i) +" from "+ datestr(t_start) + " to " + datestr(t_end));
legend({'Corr', '1/e'})
    
saveas = labels(k) + "_" + labels(i);
% print('-bestfit',"../figures/cov_"+saveas,'-dpdf')

function [c, lags] = covariance_in(temps, times, index_1,index_2, t_start, t_end, labels)
    temps_1 = temps(index_1, :);
    temps_2 = temps(index_2, :);

    [times_1, temps_1] = in_range(times, temps_1, t_start, t_end);
    [times_2, temps_2] = in_range(times, temps_2, t_start, t_end);

    [~, temps_1] = mask(times_1, temps_1);
    [~, temps_2] = mask(times_2, temps_2);

    minlen = min(length(temps_1), length(temps_2));
    
    temps_1 = temps_1(1:minlen);
    temps_2 = temps_2(1:minlen);
    
    if isempty(temps_1)
        error("Error, bad lengths")
    end
    
    maxlag = 24*60*40;
    
    [c,lags] = xcov(temps_1, temps_2, maxlag, 'normalized');
end