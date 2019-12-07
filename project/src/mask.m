function [time_out, temp_out] = mask(time_in, temp_in)
    index = ~isnan(temp_in);
    time_out = time_in(index);
    temp_out = temp_in(index);    
end

