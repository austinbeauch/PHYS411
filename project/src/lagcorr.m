function rxx = lagcorr(x)
   rxx = [];
   mu = mean(x);
   sigma = std(x);
   N = size(x, 1);
   for k = 0:40*24*60*60
       rk = 1/((N-k)*sigma^2)* sum( (x(1:end-k) - mu) .* (x(k+1:end) - mu));
       rxx = [rxx; [k/24, rk]];
   end
end