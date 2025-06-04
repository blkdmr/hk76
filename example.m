clc;clear;close all;
addpath("clustering/");

N = 15;

baseGrid = [
    0 1 0 0 1 1 0 0 0 1 0 1 0 1 0;
    0 1 1 0 0 0 1 0 0 1 1 1 1 1 1;
    0 1 0 0 0 1 1 1 1 0 0 1 0 0 0;
    1 0 1 0 1 0 1 0 0 0 1 1 0 0 0;
    0 1 0 1 1 0 1 0 0 0 1 0 0 1 0;
    0 0 1 1 1 1 1 0 1 1 1 1 1 0 1;
    0 0 1 1 1 0 0 0 0 1 1 1 1 0 1;
    0 1 0 1 1 1 1 0 1 1 1 1 0 1 0;
    0 1 0 0 1 1 0 0 1 1 1 1 0 0 1;
    1 0 0 0 0 0 0 0 1 0 0 0 0 1 0;
    0 0 0 0 1 0 1 0 1 1 0 1 1 1 1;
    1 1 0 0 0 1 0 1 0 1 1 1 1 1 1;
    1 1 1 0 0 1 1 0 1 0 0 1 0 0 0;
    0 1 0 1 1 1 1 1 0 1 1 1 0 1 1;
    1 1 1 1 0 0 0 0 1 1 1 1 1 1 0
];

figure('Visible', 'off'); 
imagesc(baseGrid);
colormap([0.2 0.2 0.2; 0.9 0 0]);  % black for 0, red for 1
saveas(gcf, 'output/basegrid.png'); 
close(gcf);

[TB, LR, LofL, labels] = hk76(baseGrid);

figure('Visible', 'off'); 
imagesc(labels);
saveas(gcf, 'output/re-labelled.png'); 
close(gcf);

disp(TB);
disp(LR);