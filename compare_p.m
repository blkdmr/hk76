clc;clear;close all;
addpath("clustering/")

probs = 0.1:0.1:1;
dim = 500;
iter = 50;

meanTime = zeros(2,length(probs));
errTime = zeros(2,length(probs));

for p = 1:length(probs)
    
    partials = zeros(1, iter);

    for i = 1:iter

        baseGrid = rand(dim) <= probs(p);
    
        tic;
        [TB, LR, LofL, labels] = hk76(baseGrid);
        
        partials(i) = toc;
    end 
   
    meanTime(1, p) = mean(partials);
    errTime(1, p) = std(partials)/sqrt(iter);
    
end

for p = 1:length(probs)
    partials = zeros(1, iter);

    for i = 1:iter
        tic;
        res = naive(dim, probs(p));
        partials(i) = toc;
    end

    meanTime(2, p) = mean(partials);
    errTime(2, p) = std(partials)/sqrt(iter);
end 

figure('Visible', 'off');
bar(probs,meanTime);
saveas(gcf, 'output/compare_p.png'); 
close(gcf);

save("output/stats_compare_p", "meanTime","errTime");