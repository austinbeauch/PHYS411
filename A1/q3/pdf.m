function dist = pdf()
n = 100000;
r = rand(n, 1);
m = mean(r);
dist = r - m;

end

