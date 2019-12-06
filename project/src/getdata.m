function [times, temps] = getdata(data, lon, lat, time_start, time_end)
    [hour_rows, hour_cols] = size(data); 
    all_times = data(3:hour_rows,1); 
    station_lon_all = data(1,2:hour_cols); 
    station_lat_all = data(2,2:hour_cols); 
    temperature_data_all = data(3:hour_rows,2:hour_cols);

    diff_lon = abs(station_lon_all - lon);  
    diff_lat = abs(station_lat_all - lat);  

    [~, station_index] = min(diff_lon+diff_lat);
    station_temps = temperature_data_all(:,station_index); 

    index = find(all_times >= time_start & all_times <= time_end);  
    times = all_times(index);
    temps = station_temps(index);
end