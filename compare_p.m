clc;clear;close all;

p = 0.1:0.1:1;
dim = 10000;
iter = 100;

hkTime = zeros(2,length(p));

for n = 1:length(p)
    
    meanTime = 0;
    
    for it = 1:iter

        baseGrid = rand(dim) <= p(n);
    
        tic;
        [LofL, labels] = hk76(baseGrid);
    
        for i = 1:dim
            for j = 1:dim
                if labels(i,j) ~= 0
                    labels(i, j) = find_root(labels(i, j), LofL);
                end
            end
        end
    
        [TB, LR] = check_percolation(labels);
        
        meanTime = meanTime + toc;

    end 
    hkTime(1, n) = meanTime / iter;
    
end

for n = 1:length(p)
    tic;
    res = naive(dim, p(n));
    hkTime(2, n) = toc;
end 


figure('Visible', 'off');
bar(p,hkTime);
legend('hk76','naive');
saveas(gcf, 'out/compare_p.png'); 
close(gcf);