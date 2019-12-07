% ASSUME MINUTE DATA HAS ALREADY BEEN LOADED
% load_minute_data  % if not
close all
months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

figure
hold on
month1 = 7;
month2 = month1 + 0;
for k = n_station_array
    temp = all_temps(k, :);
    year_mean = [];
    year_middle = [];
    for iYear = 2010:2018
        % only taking temperatures from July
        t_start = datenum(iYear,month1,1,0,0,0);
        t_end   = datenum(iYear,month2,31,23,59,59);
        index = find(times_minute >= t_start & times_minute <= t_end);  
        times = times_minute(index);
        temps = temp(index);
        m = nanmean(temps);
        year_mean = [year_mean m];
        year_middle= [year_middle (t_end+t_start)/2];
    end 
    plot(year_middle, year_mean, 'o-');
    datetick('x')
end
title("Average " + months(month1) + " Temperatues")
xlabel("Time")
ylabel("Temperature [°C]")
legend(labels, 'FontSize',8, 'Location','northwest')
% print('-bestfit','../figures/july_averages_minute','-dpdf')

for i = 1:12
    subplot(4,3,i)
    month1 = i;
    month2 = month1 + 0;
for k = 6  % 6 for UVic
%     figure(k+1)
    hold on
    % k = 5;
    temp = all_temps(k, :);
    year_mean = [];
    year_middle = [];
    for iYear = 2010:2018
        % only taking temperatures from one month
        t_start = datenum(iYear,month1,1,0,0,0);
        t_end   = datenum(iYear,month2,31,23,59,59);
        index = find(times_minute >= t_start & times_minute <= t_end);  
        times = times_minute(index);
        temps = temp(index);
        m = nanmean(temps);
        if ~isnan(m)
            year_mean = [year_mean m];
            year_middle= [year_middle (t_end+t_start)/2];
        end 
    end 
    plot(year_middle, year_mean, 'o');
    datetick('x')

    P = polyfit(year_middle, year_mean, 1);
    a = P(2);
    b = P(1);
    f = @(u) a + b*u;
    plot(year_middle, f(year_middle), 'b')

    x = year_middle;
    y = year_mean;
    N = length(x);
    t = tinv([0.05/2, 1-0.05/2], N-2);
    Sx = std(x);
    S_eps = sqrt(sum((y - f(x)).^2) / (N-2));
    delta_b = S_eps * t / (sqrt(N-1) * Sx);
    delta_a = -((a + (b+delta_b)*mean(x)) - mean(y));
    fprintf("95%% confidence interval for b: [%0.5f, %0.4f]\n", b+delta_b(1), b+delta_b(2))
    fprintf("95%% confidence for interval a: [%0.5f, %0.4f]\n", b+delta_a(1), b+delta_a(2))

    y1 = (a+delta_a(1))+(b+delta_b(1))*x;
    y2 = (a+delta_a(2))+(b+delta_b(2))*x;

    combined = [y1; y2].';
    xx = x.';
    hp = patch([xx(1:end); xx(end:-1:1); xx(1)], [combined(1:end,1); combined(end:-1:1,2); combined(2,1)], 'r');
    set(hp,'facecolor',[1,1,1]*0.8,'edgecolor','none')
    alpha(0.3) 

%     ylim([13 21])
    xlim([datenum(2010,1,1,0,0,0) datenum(2019,2,31,23,59,59)]);
    middle = (min(year_mean)+max(year_mean))/2;
    plot([min(year_middle) max(year_middle)], [middle middle], 'k--')

%     legend({'Data Points' 'Linear Fit' '95% Confidence' 'Midline'}, 'Location','northwest')
    title(months(month1))
    xlabel("Time")
    ylabel("Temperature [°C]")
end
end
suptitle("UVic Weather Station Monthly Averages")
print('-fillpage','../figures/uvic_yearly_regression','-dpdf')