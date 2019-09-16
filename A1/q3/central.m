function central(num)
i = 1;

for n = 1:num
%     dist = pdf();    
%     if isempty(total)
%         total = dist;
%     else
%         total = (total + dist) / sqrt(i);
%     end
%     subplot(4, 1, n); histogram(total); title("Plot number: " + n);
%     i = i * 2;
    disp("N: " + n);
    
    total = pdf();
    for q = 1:n-1
        disp("Adding");
        total = total + pdf(); 
    end
    
    disp("Divide by root" + i);
    total = total / sqrt(i);
    
    subplot(num, 1, n); 
    histogram(total); 
    title(n + " Distribution(s) / sqrt(" + i + ")"); 
    xlabel("Value"); 
    ylabel("Frequency");
    i = i * 2;
end

