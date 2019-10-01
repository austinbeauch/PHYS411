close all;
clear;

data = load("data/WindWaveData.dat");

wind = data(:,1);
wave = data(:,2);
N = length(wind);

figure(1)
 plot(wind, wave, '.');
 xlabel("Wind speed [m/s]")
 ylabel("Wave height [m]")
 title("Wind speed vs Wave height")
 
num = sum((wave - mean(wave)) .* (wind-mean(wind))) / (N-1);
den = std(wind) * std(wave);

r_uH = num/den;

conf_interval = sqrt(N-3)/2 * log((1+r_uH)/(1-r_uH));
fprintf("With a correlation coefficient of % 0.3f, we get a confidence interval of %0.2f ", r_uH, conf_interval);
disp("which is outside the 95% interval");

[a,b] = regress(wind, wave);
f = @(u) a + b*u;

figure(1)
 hold on;
 temp_x = linspace(min(wind), max(wind), 5);
 plot(temp_x, a+b*temp_x, 'r')

x = wind;
y = wave; 
t = tinv([0.05/2, 1-0.05/2], N-2);
Sx = std(x);
S_eps = sum((y - f(x)).^2) / (N-2);
delta_b = S_eps * t / (sqrt(N-1) * Sx);
delta_a = S_eps * t / (sqrt(N-1) * std(y));
fprintf("Slope b interval +/- %0.5f\n", delta_b(1))

figure(1)
 hold on;
 plot(temp_x, (a+delta_a(1))+(b+delta_b(1))*temp_x, 'k')
 plot(temp_x, (a+delta_a(2))+(b+delta_b(2))*temp_x, 'k')
 legend({'Data', 'Linear Fit', 'Lower interval', 'Upper interval'})
  
 
 range_10 = ((a+delta_a(2))+(b+delta_b(2))*10) - ...
     ((a+delta_a(1))+(b+delta_b(1))*10);
 
 fprintf("The range at u=10 m/s is %0.4f\n", range_10)
  
wind = [wind; 30];
wave = [wave; 33];
[a,b] = regress(wind, wave);

figure(2)
 plot(wind, wave, '.');
 xlabel("Wind speed [m/s]")
 ylabel("Wave height [m]")
 title("Wind speed vs Wave height with an additional point")
 hold on;
 temp_x = linspace(min(wind), max(wind), 5);
 plot(temp_x, a+b*temp_x, 'r')
  
bs = [];
for i = 1:1000
    mask = randperm(length(wave), 50);
    [a,b] = regress(wind(mask), wave(mask));
    bs = [bs; b];
end

figure(3)
 histogram(bs, 50)
 xlabel("Slope")
 ylabel("Frequency")
 title("Bootstrap method with 1000 iterations")
  
  
  
  
  
  
  
  
  
  
  
  
  
  