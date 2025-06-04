clc;clear;close all;
addpath("clustering/");

p = 0.6;
dim = 100;

for i=1:10000

    res = naive(dim, p);
    
    [TB, LR, LofL, labels] = hk76(res.matrice);
   
    if res.percolazioneLR ~= LR
        disp("Error in LR");
        disp(LR);
        disp(res.percolazioneLR);
    end 
    
    if res.percolazioneTB ~= TB
        disp("Error in TB");
        disp(LR);
        disp(res.percolazioneLR);
    end
    
end