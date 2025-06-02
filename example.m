clc;clear;close all;

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
saveas(gcf, 'out/basegrid.png'); 
close(gcf);

[LofL, labels] = hk76(baseGrid);

figure('Visible', 'off'); 
imagesc(labels);
saveas(gcf, 'out/labels.png'); 
close(gcf);

for i = 1:N
    for j = 1:N
        if labels(i,j) ~= 0
            labels(i, j) = find_root(labels(i, j), LofL);
        end
    end
end

figure('Visible', 'off'); 
imagesc(labels);
saveas(gcf, 'out/re-labelled.png'); 
close(gcf);

[TB, LR] = check_percolation(labels);

disp(TB);
disp(LR);