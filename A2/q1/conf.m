function [x1, x2] = conf(in1, in2)
  x1 = mean(in1) + [-1.96, 1.96] * std(in1)/sqrt(length(in1));
  x2 = mean(in2) + [-1.96, 1.96] * std(in2)/sqrt(length(in2));
  
  % checking if the 1x2 intervals overlap
  if ((x1(1) <= x2(2)) && (x2(2) <= x1(2)) || (x2(1) <= x1(2)) && (x1(2) <= x2(2)))
      disp("There is an overlap in confidence intervals at 95%.")
  else
      disp("There is an NOT overlap in confidence intervals at 95%.")
  end
  
end

