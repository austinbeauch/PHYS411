close all;
clear
deepcove = "../project/data/DeepCove_temperature_2019.dat";
jamesbay = "../project/data/JamesBay_temperature_2019.dat";

t_start_1 = datenum(2017,6,1,0,0,0);
t_end_1 = datenum(2017,9,30,0,0,0);

t_start_2 = datenum(2018,11,1,0,0,0);
t_end_2 = datenum(2019,2,18,0,0,0);

[deep_summer_times, deep_summer_temps] = getminute(deepcove, t_start_1, t_end_1);
[james_summer_times, james_summer_temps] = getminute(jamesbay, t_start_1, t_end_1);
[deep_winter_times, deep_winter_temps] = getminute(deepcove, t_start_2, t_end_2);
[james_winter_times, james_winter_temps] = getminute(jamesbay, t_start_2, t_end_2);

figure()
subplot(2,1,1);
plot(deep_summer_times, deep_summer_temps);  hold on
plot(james_summer_times, james_summer_temps)

xlabel('Time')
ylabel('Temperature [^oC]')
title('Summer Temperatues');
legend({'Deep Cove', 'James Bay'})
datetick('x')

subplot(2,1,2); 
plot(deep_winter_times, deep_winter_temps); hold on
plot(james_winter_times, james_winter_temps);
xlabel('Time')
ylabel('Temperature [^oC]')
title('Winter Temperatues');
legend({'Deep Cove', 'James Bay'})
datetick('x')

var_deep_summer = nanvar(deep_summer_temps);
var_james_summer = nanvar(james_summer_temps);
var_deep_winter = nanvar(deep_winter_temps);
var_james_winter = nanvar(james_winter_temps);

disp("The variance for Deep Cove summer is: " + var_deep_summer + "C");
disp("The variance for James Bay summer is: " + var_james_summer + "C");
disp("The variance for Deep Cove winter is: " + var_deep_winter + "C");
disp("The variance for James Bay winter is: " + var_james_winter + "C");

s_to_day = 60*60*24;
NFFT = 2^5;
[pxx_deep_summer, f_deep_summer] = ...
    pwelch(james_summer_temps, NFFT, NFFT/2, NFFT, 1/60);

figure()
loglog(f_deep_summer, pxx_deep_summer);
title("Deep Cove Summer PSD")
xlabel('Cycles per day (cpd)')
ylabel('PSD (dB/Hz)')

fSyy_deep_summer =  f_deep_summer .* pxx_deep_summer;

figure()
semilogx(f_deep_summer, fSyy_deep_summer)
xlabel('Frequency (Hz)');
ylabel('fS_{yy}');
title('Variance Preserving PSDs');









function [times, temps] = getminute(fname, time_start, time_end)
    minute_data = load(fname);
    minute_time_start = minute_data(1);
    minute_time_end = minute_data(2); 
    minute_data_points = minute_data(3);
    all_minute_times = linspace(minute_time_start, minute_time_end, minute_data_points) - 7/24;
    all_minute_temperatures = minute_data(4:minute_data_points+3);
    minute_index = find(all_minute_times >= time_start & all_minute_times <= time_end); 
    times = all_minute_times(minute_index);
    temps = all_minute_temperatures(minute_index);
end