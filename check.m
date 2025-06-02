clc;clear;close all;

p = 0.5;
dim = 100;

for i=1:10000

    res = naive(dim, p);
    
    [LofL, labels] = hk76(res.matrice);
    
    for j = 1:dim
        for k = 1:dim
            if labels(j,k) ~= 0
                labels(j, k) = find_root(labels(j, k), LofL);
            end
        end
    end
    
    [TB, LR] = check_percolation(labels);
    
    
    if res.percolazioneLR ~= LR
        disp("Error in LR");
    end 
    
    if res.percolazioneTB ~= TB
        disp("Error in TB");
    end
end