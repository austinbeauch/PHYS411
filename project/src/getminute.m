function [times, temps] = getminute(fname, time_start, time_end)
    minute_data = load(fname);
    minute_time_start = minute_data(1);
    minute_time_end = minute_data(2); 
    minute_data_points = minute_data(3);
    all_minute_times = linspace(minute_time_start, minute_time_end, minute_data_points) - 7/24;
    all_minute_temperatures = minute_data(4:minute_data_points+3);
    minute_index = find(all_minute_times >= time_start & all_minute_times <= time_end); 
    times = all_minute_times(minute_index);
    temps= all_minute_temperatures(minute_index);
end