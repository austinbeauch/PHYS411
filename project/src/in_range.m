function [times,temps] = in_range(time_in, temp_in, t_start, t_end)
        index = find(time_in >= t_start & time_in <= t_end);  
        times = time_in(index);
        temps = temp_in(index);
end

