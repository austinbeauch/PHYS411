loops = 5;
numbers = 1000000;

i = 1;
for iloop = 1:loops
    
    pdf = rand(numbers, 1) - 0.5;
    for q = 1:i-1
        pdf = pdf + rand(numbers, 1) - 0.5; 
    end
    
    pdf = pdf / sqrt(i);
    
    subplot(loops, 1, iloop); 
    histogram(pdf, 100, 'EdgeColor', 'none', 'normalization', 'pdf'); 
    x = (min(pdf) : 0.1 : max(pdf));
    y = normpdf(x, nanmean(pdf), nanstd(pdf));
    hold on;
    plot(x,y)
    hold off;
    title(iloop + " Distribution(s) / sqrt(" + i + ")"); 
    xlabel("X"); 
    ylabel("Frequency");
    
    i = i * 2;
end