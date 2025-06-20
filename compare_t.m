clc;clear;close all;
addpath("clustering/");

prob = 0.6;
dims = 100:100:1000;
iter = 50;

meanTime = zeros(2,length(dims));
errTime  = zeros(2,length(dims));

for d = 1:length(dims)
    
    partials = zeros(1, iter);

    for i = 1:iter

        baseGrid = rand(dims(d)) <= prob;
    
        tic;
        [TB, LR, LofL, labels] = hk76(baseGrid);
        partials(i) = toc;
    end 
   
    meanTime(1, d) = mean(partials);
    errTime(1, d) = std(partials)/sqrt(iter);

end

for d = 1:length(dims)

    partials = zeros(1, iter);

    for i = 1:iter
        tic;
        res = naive(dims(d), prob);
        partials(i) = toc;
    end

    meanTime(2, d) = mean(partials);
    errTime(2, d) = std(partials)/sqrt(iter);

end 

figure('Visible', 'off');
bar(dims,meanTime);
saveas(gcf, 'output/compare_t.png'); 
close(gcf);

save("output/stats_compare_t", "meanTime","errTime"); 