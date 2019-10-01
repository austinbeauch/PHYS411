function [a,b] = regress(x,y)
N = length(x);
b_num = (N*sum(x.*y) - sum(x)*sum(y));
b_dem = N*sum(x.^2) - (sum(x))^2;
b = b_num / b_dem;
a = (sum(y) - b*sum(x)) / N; 
end

